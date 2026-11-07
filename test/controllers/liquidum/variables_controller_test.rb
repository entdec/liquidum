require "test_helper"

module Liquidum
  class VariablesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @token = Variables.new(order: OrderDrop).token
    end

    test "lists the variables at a path" do
      get variables_url(roots: @token, path: "order.customer")
      assert_response :success

      body = JSON.parse(@response.body)
      assert_equal "order.customer", body["path"]
      assert_includes body["variables"], {"name" => "orders", "label" => "Orders", "type" => "object", "collection" => true, "children" => true}
      assert_includes body["variables"], {"name" => "email", "label" => "Email", "type" => "string", "collection" => false, "children" => false}
    end

    test "lists the roots without a path" do
      get variables_url(roots: @token)
      assert_response :success
      assert_equal [{"name" => "order", "label" => "Order", "type" => "object", "collection" => false, "children" => true}],
        JSON.parse(@response.body)["variables"]
    end

    test "refuses roots that are not signed" do
      get variables_url(roots: {order: {drop: "OrderDrop"}}.to_json)
      assert_response :bad_request
    end

    test "an unknown path is not found" do
      get variables_url(roots: @token, path: "order.nope")
      assert_response :not_found
    end
  end
end
