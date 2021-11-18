# frozen_string_literal: true

module ArraywrapFilter
  # Converts string to date time using format
  #
  # Example:
  #   <div class="date">{{'08012020 09:01:00'| strptime: '%D%M%Y %H:%S:%M'}}</div>
  ##
  def array_wrap(input)
     Array.wrap(input)
  end
end

Liquid::Template.register_filter(ArraywrapFilter)
