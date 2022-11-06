# frozen_string_literal: true

require 'test_helper'
require 'pry'

class UnescapeHTMLTest < ActiveSupport::TestCase
  test 'unescape HTML tags' do
    template_data = "{{payload.test['MESSAGE']['STRING']['$'] | unescape_html}}"

    result = Liquidum.render(template_data, assigns: { 'payload' => { 'test' => {
                             'MESSAGE' => {
                               'STRING' => {
                                 '$' => '&lt;script&gt;let string = &#x60;${location.href}&#x60;;&lt;/script&gt;&apos;'
                               }
                             }
                           } } })
    assert_equal '<script>let string = `${location.href}`;</script>\'', result
  end
end
