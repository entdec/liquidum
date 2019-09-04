# frozen_string_literal: true

require 'test_helper'

# pp mini.parse("method='post' action='/test'")
# parse(%[method="post" action='/test' method=method action=theaction])
# parse(%[shipment method=themethod method="post" action="/test" 'hoi' action=theaction])
# parse(%[user method=themethod method="post" action="/test" action=theaction])
# parse("user shipment method action")

class ParserTest < ActiveSupport::TestCase
  test 'parses standalone literal' do
    args = Liquor::Tag::Parser.new("shipment").args
    assert_includes args, literal: 'shipment'
  end

  test 'parses repeated standalone literal' do
    args = Liquor::Tag::Parser.new("shipment user").args
    assert_includes args, literal: 'shipment'
    assert_includes args, literal: 'user'
  end

  test 'parses quoted literal' do
    args = Liquor::Tag::Parser.new("'shipment'").args
    assert_includes args, quoted: 'shipment'
  end

  test 'parses repeated quoted literal' do
    args = Liquor::Tag::Parser.new("'shipment' 'user'").args
    assert_includes args, quoted: 'shipment'
    assert_includes args, quoted: 'user'
  end

  test 'parses quoted and standalone literal' do
    args = Liquor::Tag::Parser.new("'shipment' user").args
    assert_includes args, quoted: 'shipment'
    assert_includes args, literal: 'user'
  end

  test 'parses quoted attribute value' do
    args = Liquor::Tag::Parser.new("method='post'").args
    assert_includes args, attr: 'method', value: 'post'
  end

  test 'parses literal attribute value' do
    args = Liquor::Tag::Parser.new("method=post").args
    assert_includes args, attr: 'method', lvalue: 'post'
  end

  test 'parses literal attribute value with dot' do
    args = Liquor::Tag::Parser.new("url=request.fullpath").args
    assert_includes args, attr: 'url', lvalue: 'request.fullpath'
  end

  test 'parses combination' do
    args = Liquor::Tag::Parser.new(%[shipment method=themethod method="post" action="/test" 'hoi' action=theaction position=:left]).args
    assert_includes args, literal: 'shipment'
    assert_includes args, attr: 'method', lvalue: 'themethod'
    assert_includes args, attr: 'action', lvalue: 'theaction'
    assert_includes args, attr: 'position', svalue: 'left'
    assert_includes args, attr: 'method', value: 'post'
    assert_includes args, attr: 'action', value: '/test'
    assert_includes args, quoted: 'hoi'
  end

  test 'parses complicated literal' do
    args = Liquor::Tag::Parser.new("locale request.query_parameters['lang']").args
    assert_includes args, literal: 'locale'
    assert_includes args, literal: "request.query_parameters['lang']"
  end
end
