# frozen_string_literal: true

require 'test_helper'
require 'pry'

class StrptimeTest < ActiveSupport::TestCase
  test 'creates a date' do
    template_data = "{{'08012020 09:01:00'| strptime: '%d%m%Y %H:%S:%M'}}"

    result = Liquidum.render(template_data, assigns: { 'payload' => { 'test' => 'blah' } })
    assert_equal '2020-01-08T09:00:01+00:00', result
  end
end
