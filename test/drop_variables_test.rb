# frozen_string_literal: true

require "test_helper"

class DropVariablesTest < ActiveSupport::TestCase
  def variable(name)
    OrderDrop.variables.find { |v| v.name == name }
  end

  test "lists what Liquid can call, not the helpers of every drop" do
    assert_equal %w[customer id number order_lines placed_at portal_url total], OrderDrop.variables.map(&:name)
  end

  test "leaves out methods that need arguments" do
    assert_nil variable("line")
  end

  test "labels attributes with human_attribute_name" do
    assert_equal "Order number", variable("number").label
    assert_equal "Placed at", variable("placed_at").label
  end

  test "types attributes from the model" do
    assert_equal "string", variable("number").type
    assert_equal "datetime", variable("placed_at").type
  end

  test "follows associations to their drops" do
    customer = variable("customer")
    assert_equal "Ordered by", customer.label
    assert_equal "object", customer.type
    assert_equal CustomerDrop, customer.drop
    refute customer.collection

    lines = variable("order_lines")
    assert_equal OrderLineDrop, lines.drop
    assert lines.collection
  end

  test "takes labels, types and hints from describe" do
    assert_equal "money", variable("total").type
    assert_equal "Including VAT", variable("total").hint
  end

  test "labels in the current locale" do
    I18n.with_locale(:nl) do
      assert_equal "Bestelnummer", variable("number").label
      assert_equal "Link naar de bestelling", variable("portal_url").label
    end
  end

  test "translates a label given as a proc" do
    assert_equal "Link to the order", variable("portal_url").label
  end

  test "describe can give a method a drop" do
    drop = Class.new(OrderDrop) do
      def self.name = "OrderDrop"

      def buyer = customer
      describe :buyer, drop: "CustomerDrop"
    end
    buyer = drop.variables.find { |v| v.name == "buyer" }
    assert_equal CustomerDrop, buyer.drop
    assert_equal "object", buyer.type
  end
end
