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

  def translate(input, options = {})
    result = nil

    Liquor.config.i18n_store(@context) do |obj|
      locale = options.delete('locale')

      key = input
      scope = nil

      if key.start_with?('.')
        key = input[1..-1]
        scope = obj.translation_scope
      end

      result = I18n.t(key, locale: locale, scope: scope, cascade: { skip_root: false }, **options)
      result = I18n::Backend::Simple.new.send(:interpolate, I18n.locale, result, options.symbolize_keys) if result
    end

    result
  end
  alias_method :t, :translate
end

Liquid::Template.register_filter(TranslateFilter)
