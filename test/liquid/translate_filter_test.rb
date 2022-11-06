# frozen_string_literal: true

require 'test_helper'

class TranslateFilterTest < ActiveSupport::TestCase
  setup do
    Liquidum.config.i18n_store = ->(context, block) { I18n::Backend::KeyValue.new({'index.test' => 'Test'}) }
  end

  test 'will allow translations' do
    skip 'To be revised'

    subject = "{{'index.test'|t: locale: 'en'}}"
    result = Liquidum.render(subject)

    assert_not_includes result, 'translation missing'
    assert_equal 'Test', result
  end

  test 'will allow translations, with short filter name' do
    skip 'To be revised'

    subject = "{{'.test'|t: locale: 'en'}}"
    result = Liquidum.render(subject)

    assert_not_includes result, 'translation missing'
    assert_equal 'Test', result
  end

  test 'will allow translations, with short filter name, without language' do
    skip 'To be revised'

    subject = @contents.create!(path: '/index.html', full_path: '/index.html', kind: 'text', data: "{{'.test'|t}}", parent: nil)
    result = Scribo::ContentRenderService.new(subject, self).call

    assert_not_includes result, 'translation missing'
    assert_equal 'Test', result
  end

  test 'cascades translations' do
    skip 'To be revised'

    subject = @contents.create!(path: '/index.html', full_path: '/index.html', kind: 'text', data: "{{'some.key.test'|t}}", parent: nil)
    result = Scribo::ContentRenderService.new(subject, self).call

    assert_not_includes result, 'translation missing'
    assert_equal 'Test on root of locale', result
  end

  test 'does not conflict with app locale for root key' do
    skip 'To be revised'

    result = I18n.t('hello')
    assert_equal 'Hello world', result
  end

  test 'does not conflict with app locale for nested key' do
    skip 'To be revised'

    result = I18n.t('some.hatseflats')
    assert_equal 'Hatseflats', result
  end
end
