# frozen_string_literal: true

require 'test_helper'
require 'pry'

class ToFilterTest < ActiveSupport::TestCase
  test 'dumps data as json' do
    template_data = "{{payload | to: 'json'}}"

    result = Liquor.render(template_data, assigns: {'payload' => {'test' => 'blah'}})
    assert_equal '{"test":"blah"}', result
  end
  test 'dumps data as formatted json' do
    template_data = "{{payload | to: 'json', pretty: true}}"

    result = Liquor.render(template_data, assigns: {'payload' => {'test' => 'blah'}})
    assert_equal "{\n  \"test\": \"blah\"\n}", result
  end
  test 'dumps data as yaml' do
    template_data = "{{payload | to: 'yaml', inline: true}}"

    result = Liquor.render(template_data, assigns: {'payload' => {'test' => 'blah'}})
    assert_equal "test: blah\n", result
  end
  test 'dumps data as yaml with start' do
    template_data = "{{payload | to: 'yaml'}}"

    result = Liquor.render(template_data, assigns: {'payload' => {'test' => 'blah'}})
    assert_equal "---\ntest: blah\n", result
  end
end
