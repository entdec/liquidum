# frozen_string_literal: true

require 'liquid'
require 'tilt'
require 'sassc'

require 'liquor/version'
require 'liquor/engine'
require 'liquor/configuration'

require 'liquor/liquid/drops/active_model/errors_drop'
require 'liquor/liquid/liquid_helpers'
require 'liquor/liquid/liquid_template_extensions'
require 'liquor/liquid/liquor_block'
require 'liquor/liquid/liquor_tag'
require 'liquor/liquid/parser'

module Liquor
  class Error < StandardError; end
  class UnknownStepTypeError < Error; end

  class LiquorFileSystem
    attr_reader :registers
    def initialize(registers)
      @registers = registers
    end

    def read_template_file(template_path)
      current_content = registers['content']

      contents = current_content.site.contents.published

      content = contents.include(template_path).first
      content ||= contents.identified(template_path).first
      content&.data || ''
    end
  end

  class << self
    attr_reader :config

    def setup
      @config = Configuration.new
      yield config
    end

    def render(content, options = {})
      template = Liquid::Template.parse(content)
      options[:assigns] ||= {}
      options[:registers] ||= {}
      options[:registers]['file_system'] = Liquor.config.liquor_file_system.constantize.new(options[:registers])
      result = template.render(options[:context] || options[:assigns].stringify_keys, registers: options[:registers])

      if template.errors.present?
        Liquor.config.logger.error '--- Template rendering errors: ' + '-' * 49
        template.errors.map do |error|
          next unless error.cause

          Liquor.config.logger.error error
          Liquor.config.logger.error '=> ' + error.cause.backtrace.first.to_s + ': ' + error.cause.message
        end
        Liquor.config.logger.error '-' * 80
      end

      options[:assigns].deep_merge!(template.assigns.stringify_keys) if template.assigns
      options[:registers].deep_merge!(template.registers.stringify_keys) if template.registers

      result = Tilt[options[:filter]].new { result }.render if options[:filter].present? && Tilt[options[:filter]]
      if options[:layout].present?
        options[:registers]['_yield']     = {} unless options[:registers]['_yield']
        options[:registers]['_yield'][''] = result.delete("\n")
        result = render(options[:layout], assigns: options[:assigns], registers: options[:registers])
      end
      result
    end
  end
end
