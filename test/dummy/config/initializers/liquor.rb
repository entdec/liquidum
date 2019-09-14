# frozen_string_literal: true

Liquor.setup do |config|
  config.translation_scope = lambda do |context|
    'main.test'
  end
end
