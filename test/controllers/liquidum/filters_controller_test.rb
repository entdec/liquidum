require "test_helper"

module Liquidum
  class FiltersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "lists the filters Liquid has, with their arguments and what they keep" do
      get filters_url
      assert_response :success

      filters = JSON.parse(@response.body)["filters"].index_by { |filter| filter["name"] }
      assert_equal({"name" => "where", "label" => "Those whose property has the value", "arguments" => [{"name" => "property", "kind" => "property"}, {"name" => "value", "kind" => "value"}], "keeps" => "collection"}, filters["where"])
      assert_equal [{"name" => "format", "kind" => "format"}], filters["date"]["arguments"]
      assert_equal "item", filters["first"]["keeps"]
      assert_equal [{"name" => "key", "kind" => "key"}], filters["t"]["arguments"]
      # Liquidum's own too
      assert_equal [{"name" => "locale", "kind" => "any"}, {"name" => "format", "kind" => "format"}], filters["localize"]["arguments"]
    end

    test "a filter that isn't described has its name and no arguments" do
      filter = Module.new do
        def shout(input)
          input.upcase
        end
      end
      Liquid::Environment.default.register_filter(filter)
      get filters_url
      assert_includes JSON.parse(@response.body)["filters"], {"name" => "shout", "label" => "Shout", "arguments" => []}
    end
  end
end
