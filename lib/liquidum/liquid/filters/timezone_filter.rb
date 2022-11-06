# frozen_string_literal: true

module TimezoneFilter
  # Convert between timezones
  # Inspired by: http://customer.io/docs/dates-timezones.html
  # See: http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
  #
  # Examples:
  #
  # {{ date_time | timezone: 'Europe/Amsterdam' }}
  #
  # Changes like +3 or -4 or not (yet) possible
  def timezone(input, to_zone = 'UTC')
    input.utc.in_time_zone(to_zone)
  end
end

Liquid::Template.register_filter(TimezoneFilter)
