require 'liquid'
require 'tilt'
require 'sassc'

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

  class << self
    def config
      @config = Liquor::Configuration.new
    end

    def setup
      yield config
    end

    def render(content, options = {})
      template = Liquid::Template.parse(content)
      result   = template.render(options[:assigns], registers: options[:registers])

      errors = template.errors.map { |error| error.try(:cause)&.message }.join(', ')
      Liquor.config.logger.error "Template rendering error on: #{errors}" if errors.present?

      assigns   = template.assigns.stringify_keys.merge(options[:assigns])
      registers = template.registers.stringify_keys.merge(options[:registers])

      result    = Tilt[options[:filter]].new { result }.render if options[:filter].present?
      if options[:layout]
        registers['_yield']     = {} unless registers['_yield']
        registers['_yield'][''] = result.delete("\n")
        result                  = render(options[:layout], assigns: assigns, registers: registers)
      end
      result
    end
  end
end