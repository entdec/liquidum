# frozen_string_literal: true

module TranslateFilter
  # Translate text
  #
  # Example:
  #   <div class="summary">{{'.title' | t}}</div>
  #
  # provide optional locale to translate the text in, if you don't pass it it will use I18n.locale
  #
  #   <div class="summary">{{'.title' | t: locale: 'nl'}}</div>
  #
  # you can provide additional arguments to be used for interpolation:
  #
  #   <div class="summary">{{'.title' | t: gender: 'm', locale: 'nl'}}</div>
  #
  def translate(input, options)
    scope = Liquor.config.translation_scope(@context)
    locale = options.delete('locale')
    I18n.t(input, options, locale: locale, scope: scope, cascade: true)
  end
  alias_method :t, :translate
end

Liquid::Template.register_filter(TranslateFilter)
