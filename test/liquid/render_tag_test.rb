# frozen_string_literal: true

require 'test_helper'

class RenderTagTest < ActiveSupport::TestCase
  test 'renders a variable as Liquid' do
    result = Liquidum.render('{%render body%}', assigns: { 'body' => 'Hello {{ name }}', 'name' => 'world' })
    assert_equal 'Hello world', result
  end

  test 'renders with the registers of the outer template' do
    template = Liquid::Template.parse("{%render body%}")
    result = template.render({ 'body' => "{%helper content_tag 'p' 'Hello world'%}" },
                             registers: { 'controller' => ApplicationController.new })
    assert_equal '<p>Hello world</p>', result
  end
end
