require 'liquor/engine'
require 'liquor/configuration'

module Liquor
  class Error < StandardError; end
  class UnknownStepTypeError < Error; end

  class << self
    attr_reader :config

    def setup
      @config = Vorto::Config.new
      yield config
    end

    def render(content, assigns, registers, options = {})
      template = Liquid::Template.parse(content)
      result   = template.render(assigns, registers: registers)

      errors = template.errors.map { |error| error.try(:cause)&.message }.join(', ')
      Liquir.config.logger.error "Template rendering error on #{content.id}: #{errors}" if errors.present?

      assigns   = template.assigns.stringify_keys.merge(assigns)
      registers = template.registers.stringify_keys.merge(registers)

      result    = Tilt[options[:filter]].new { result }.render if options[:filter].present?
      if content.layout
        registers['_yield']     = {} unless registers['_yield']
        registers['_yield'][''] = result.delete("\n")
        result                  = render_with_liquid(content.layout, assigns, registers)
      end
      result
    end
  end
end
