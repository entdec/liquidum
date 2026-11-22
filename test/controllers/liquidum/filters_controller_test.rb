require "test_helper"

module Liquidum
  class FiltersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "lists the filters Liquid has, with their arguments and what they keep" do
      get filters_url
      assert_response :success

      filters = JSON.parse(@response.body)["filters"].index_by { |filter| filter["name"] }
      assert_equal({"name" => "where", "label" => "Those whose property has the value", "arguments" => [{"name" => "property", "kind" => "property", "optional" => false}, {"name" => "value", "kind" => "value", "optional" => true}], "keeps" => "collection"}, filters["where"])
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
      assert_equal [{"name" => "locale", "kind" => "locale", "values" => locales, "optional" => true}, date.merge("optional" => true)], filters["localize"]["arguments"]
      # Which can be left out, from the filter's method; what map leaves
      assert_equal [false], filters["date"]["arguments"].map { |argument| argument["optional"] }
      assert_equal [true, true], filters["truncate"]["arguments"].map { |argument| argument["optional"] }
      assert_equal "property", filters["map"]["keeps"]
    end

    test "a filter that isn't described has its name and its method's arguments, not named ones" do
      filter = Module.new do
        def shout(input)
          input.upcase
        end

        def pad(input, width, char = " ", options = {})
          input.to_s.rjust(width, char)
        end

        def glue(input, *parts)
          [input, *parts].join
        end
      end
      Liquid::Environment.default.register_filter(filter)
      get filters_url
      filters = JSON.parse(@response.body)["filters"]
      assert_includes filters, {"name" => "shout", "label" => "Shout", "arguments" => []}
      assert_includes filters, {"name" => "pad", "label" => "Pad", "arguments" => [{"name" => "width", "kind" => "any", "optional" => false}, {"name" => "char", "kind" => "any", "optional" => true}]}
      # Any number of them: none known
      assert_includes filters, {"name" => "glue", "label" => "Glue", "arguments" => []}
    end
  end
end
