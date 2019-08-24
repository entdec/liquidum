# frozen_string_literal: true

module LocalizeFilter
  # Localize date/time
  # See: http://guides.rubyonrails.org/i18n.html
  #
  # Examples:
  #
  # {{ date_time | localize: 'nl', '%d %b %R' }}
  def localize(input, locale = 'en', format = nil)
    I18n.l(input, format: format, locale: locale)
  end
end

Liquid::Template.register_filter(LocalizeFilter)
