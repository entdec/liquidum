# frozen_string_literal: true

require "test_helper"

class VariablesTest < ActiveSupport::TestCase
  setup do
    @variables = Liquidum::Variables.new(order: OrderDrop, portal_url: :string)
  end

  test "lists the roots without a path" do
    roots = @variables.at("")
    assert_equal %w[order portal_url], roots.map(&:name)
    assert_equal "Order", roots.first.label
    assert_equal "string", roots.last.type
  end

  test "lists the variables of a nested path" do
    assert_equal %w[email id name orders], @variables.at("order.customer").map(&:name)
  end

  test "goes into the elements of a collection" do
    assert_equal %w[id name], @variables.at("order.order_lines.product").map(&:name)
  end

  test "follows associations back" do
    assert_equal OrderDrop.variables.map(&:name), @variables.at("order.customer.orders").map(&:name)
  end

  test "returns nothing for an unknown path or a value without variables" do
    assert_nil @variables.at("order.nope")
    assert_nil @variables.at("invoice")
    assert_nil @variables.at("order.number")
  end

  test "roots survive a token" do
    variables = Liquidum::Variables.from_token(@variables.token)
    assert_equal({"order" => OrderDrop, "portal_url" => "string"}, variables.roots)
  end

  test "a tampered token is refused" do
    assert_nil Liquidum::Variables.from_token(@variables.token.reverse)
    assert_nil Liquidum::Variables.from_token(nil)
  end
end
