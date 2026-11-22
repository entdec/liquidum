require "test_helper"

module Liquidum
  class TagsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "lists the tags Liquid has, how they're written and whether they're blocks" do
      get tags_url
      assert_response :success

      tags = JSON.parse(@response.body)["tags"].index_by { |tag| tag["name"] }
      assert_equal({"name" => "if", "label" => "Only when a condition holds", "syntax" => "if condition", "block" => true}, tags["if"])
      assert_equal({"name" => "assign", "label" => "Sets a variable", "syntax" => "assign variable = value", "block" => false}, tags["assign"])
      assert_equal true, tags["raw"]["block"]
      assert_equal "break", tags["break"]["syntax"]
      # Liquidum's own, not the inline comment
      assert_equal "render 'name'", tags["render"]["syntax"]
      assert_nil tags["#"]
    end
  end
end
