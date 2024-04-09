# frozen_string_literal: true

require "liquid"
require "tilt"
require "sassc"
require "addressable/uri"

require "liquidum/version"
require "liquidum/engine"
require "liquidum/configuration"
require "liquidum/drop"

require "liquidum/liquid/liquid_helpers"
require "liquidum/liquid/liquid_template_extensions"
require "liquidum/liquid/liquidum_block"
require "liquidum/liquid/liquidum_tag"
require "liquidum/liquid/parser"

module Liquidum
  extend Configurable

  class Error < StandardError; end

  class UnknownStepTypeError < Error; end

  class LiquidumFileSystem
    attr_reader :registers

    def initialize(registers)
      @registers = registers
    end

    def read_template_file(template_path)
      current_content = registers["content"]

      contents = current_content.site.contents.published

      content = contents.include(template_path).first
      content&.data || ""
    end
  end

  class << self
    def render(content, options = {})
      template = Liquid::Template.parse(content)
      options[:assigns] ||= {}
      options[:registers] ||= {}
      options[:registers]["file_system"] =
        Liquidum.config.liquidum_file_system.constantize.new(options[:registers])
      result = template.render(options[:context] || options[:assigns].stringify_keys,
        registers: options[:registers])

      if template.errors.present?
        Liquidum.config.logger.error "--- Template rendering errors: " + "-" * 49
        template.errors.map do |error|
          next unless error.cause

          Liquidum.config.logger.error error
          Liquidum.config.logger.error "=> " + error.cause.backtrace.first.to_s + ": " + error.cause.message
        end
        Liquidum.config.logger.error "-" * 80
      end

      assigns = options[:assigns].deep_stringify_keys
      assigns = assigns.merge(template.assigns.stringify_keys) if template.assigns
      options[:registers].deep_merge!(template.registers.stringify_keys) if template.registers

      if options[:filter].present? && Tilt[options[:filter]]
        result = Tilt[options[:filter]].new(options[:filter_options]) do
          result
        end.render
      end
      if options[:layout].present?
        result = render(options[:layout], assigns: assigns.merge("content" => result),
          registers: options[:registers])
      end

      result
    end
  end
end
