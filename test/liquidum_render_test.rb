# frozen_string_literal: true

require 'test_helper'

class LiquidumRenderTest < ActiveSupport::TestCase
  test 'renders in the context of a tag, with its registers' do
    context = Liquid::Context.new({ 'name' => 'world' }, {}, { 'controller' => ApplicationController.new })
    result = Liquidum.render("Hello {{ name }}{%helper content_tag 'p' '!'%}", context: context, registers: context.registers)
    assert_equal 'Hello world<p>!</p>', result
  end
end
