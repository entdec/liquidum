# frozen_string_literal: true

module FormatFilter
  # Applies format to input
  #
  # Example:
  #   <div class="summary">{{title | format: '%20s'}}</div>
  ##
  def format(input, format_string)
    Kernel.format(format_string, input)
  end
end

Liquid::Template.register_filter(FormatFilter)
