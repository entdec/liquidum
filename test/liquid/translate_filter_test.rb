# frozen_string_literal: true

require "test_helper"

class TranslateFilterTest < ActiveSupport::TestCase
  # A backend that looks a key up from its scope towards the root
  class CascadingBackend < I18n::Backend::KeyValue
    include I18n::Backend::Cascade
  end

  setup do
    @i18n_store = Liquidum.config.instance_variable_get(:@i18n_store)
    @translation_scope = Liquidum.config.instance_variable_get(:@translation_scope)
    Liquidum.config.i18n_store = ->(context) { I18n::Backend::KeyValue.new({"en.index.test" => "\"Test\""}) }
  end

  teardown do
    Liquidum.config.i18n_store = @i18n_store
    Liquidum.config.translation_scope = @translation_scope
  end

  test "will allow translations" do
    subject = "{{'index.test'|t: locale: 'en'}}"
    result = Liquidum.render(subject)

    assert_not_includes result, "translation missing"
    assert_equal "Test", result
  end

  test "interpolates its arguments" do
    Liquidum.config.i18n_store = ->(context) { I18n::Backend::KeyValue.new({"en.greeting" => "\"Hello %{name}\""}) }

    assert_equal "Hello Alice", Liquidum.render("{{'greeting' | t: name: name, locale: 'en'}}", assigns: {"name" => "Alice"})
  end

  test "translates a key that starts with a dot in the scope from the context" do
    Liquidum.config.i18n_store = ->(context) { CascadingBackend.new({"en.order.mail.title" => "\"Your order\"", "en.footer" => "\"Bye\""}) }
    Liquidum.config.translation_scope = ->(context) { context.registers["scope"] }

    result = Liquidum.render("{{'.title' | t: locale: 'en'}} {{'.footer' | t: locale: 'en'}}", registers: {"scope" => "order.mail"})

    assert_equal "Your order Bye", result
  end

  test "translates with the app's own translations by default" do
    Liquidum.config.i18n_store = @i18n_store
    I18n.backend.store_translations(:en, liquidum_test: {hello: "Hello from the app"})

    assert_equal "Hello from the app", Liquidum.render("{{'liquidum_test.hello' | t: locale: 'en'}}")
  end
end
