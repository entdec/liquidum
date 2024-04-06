# frozen_string_literal: true

require "test_helper"

class TranslateFilterTest < ActiveSupport::TestCase
  setup do
    Liquidum.config.i18n_store = ->(context) { I18n::Backend::KeyValue.new({"en.index.test" => "\"Test\""}) }
  end

  test "will allow translations" do
    subject = "{{'index.test'|t: locale: 'en'}}"
    result = Liquidum.render(subject)

    assert_not_includes result, "translation missing"
    assert_equal "Test", result
  end
end
