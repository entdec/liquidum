# frozen_string_literal: true

module TranslateFilter
  # Translate text
  #
  # Example:
  #   <div class="summary">{{'.title' | t}}</div>
  #
  # provide optional locale to translate the text in, if you don't pass it it will use I18n.locale
  #
  def translate(input, locale = I18n.locale)
    scope = Liquor.config.translation_scope(@context)
    I18n.t(input, locale: locale, scope: scope, cascade: true)
  end
  alias_method :t, :translate
end

Liquid::Template.register_filter(TranslateFilter)
