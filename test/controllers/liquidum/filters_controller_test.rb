require "test_helper"

module Liquidum
  class FiltersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "lists the filters Liquid has, with their arguments and what they keep" do
      get filters_url
      assert_response :success

      filters = JSON.parse(@response.body)["filters"].index_by { |filter| filter["name"] }
      assert_equal({"name" => "where", "label" => "Those whose property has the value", "arguments" => [{"name" => "property", "kind" => "property"}, {"name" => "value", "kind" => "value"}], "keeps" => "collection"}, filters["where"])
      date = filters["date"]["arguments"].sole
      assert_equal "format", date["kind"]
      # The app's own formats, each once
      assert_includes date["values"], {"value" => I18n.t("date.formats.long"), "label" => "Date, long"}
      assert_includes date["values"], {"value" => I18n.t("time.formats.short"), "label" => "Time, short"}
      assert_equal date["values"].uniq { |format| format["value"] }, date["values"]
      assert_equal "item", filters["first"]["keeps"]
      assert_equal [{"name" => "key", "kind" => "key"}], filters["t"]["arguments"]
      # Liquidum's own too
      locales = I18n.available_locales.map { |locale| {"value" => locale.to_s, "label" => locale.to_s} }
      assert_equal [{"name" => "locale", "kind" => "locale", "values" => locales}, date], filters["localize"]["arguments"]
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
