# frozen_string_literal: true

module StrptimeFilter
  # Converts string to date time using format
  #
  # Example:
  #   <div class="date">{{'08012020 09:01:00'| strptime: '%D%M%Y %H:%S:%M'}}</div>
  ##
  def strptime(input, format_string)
    DateTime.strptime(input, format_string)
  end
end

Liquid::Template.register_filter(StrptimeFilter)
