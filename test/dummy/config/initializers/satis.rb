# frozen_string_literal: true

# As host apps do: Satis's own default help text doesn't work
Satis.setup do |config|
  config.default_help_text = lambda do |_template, _object, key, _additional_scope|
    I18n.t((["help"] + [key.to_s]).join("."), default: nil)
  end
end
