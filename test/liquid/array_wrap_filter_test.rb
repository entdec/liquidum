# frozen_string_literal: true

require 'test_helper'
require 'pry'

class ArrayWrapTest < ActiveSupport::TestCase
  test 'wraps an object in with an array if it is not already an array' do
    template_data = "{%assign res = payload.test['MESSAGE']['ITEM'] | array_wrap %}{%for item in res %}{{item['PN']['$']}}{%endfor%}"

    result = Liquidum.render(template_data, assigns: { 'payload' => { 'test' => {
                             'MESSAGE' => {
                               'ITEM' => {
                                 'PN' => {
                                   '$' => '1.0.03.04.10264'
                                 },
                                 'STRING' => {
                                   '$' => 'The brown fox jumped over the lazy dog.'
                                 }
                               }
                             }
                           } } })
    assert_equal '1.0.03.04.10264', result
  end
end
