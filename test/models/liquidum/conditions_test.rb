# frozen_string_literal: true

require "test_helper"

module Liquidum
  # The cases are the browser's too (test/javascript/conditions_test.js)
  class ConditionsTest < ActiveSupport::TestCase
    CASES = JSON.parse(File.read(File.expand_path("../../fixtures/files/conditions_cases.json", __dir__)))

    # {"$date" => "2027-03-10"} is a date
    def self.values_of(value)
      case value
      when Hash then (value.keys == ["$date"]) ? Date.parse(value["$date"]) : value.transform_values { |element| values_of(element) }
      when Array then value.map { |element| values_of(element) }
      else value
      end
    end

    CASES["cases"].each do |example|
      test "a case: #{example["name"]}" do
        conditions = Conditions.new("match" => example["match"], "rules" => example["rules"])
        assert_equal example["met"], conditions.met?(self.class.values_of(example["values"]))
      end
    end

    def rule(variable, operator, value = nil, value_to = nil)
      {"variable" => variable, "operator" => operator, "value" => value, "value_to" => value_to}
    end

    test "a drop's variables, and its questions" do
      drop = Class.new(Liquid::Drop) do
        def state = "active"

        def active? = true
      end.new

      assert Conditions.new("rules" => [rule("user.state", "is", "Active"), rule("user.active?", "is", "yes")]).met?("user" => drop)
      assert_not Conditions.new("rules" => [rule("user.active?", "is", "false")]).met?(user: drop)
    end

    test "a time compares as a time, with the value in the app's time zone" do
      Time.use_zone("Amsterdam") do
        values = {"ticket" => {"created_at" => Time.zone.parse("2027-03-10 09:30")}}
        assert Conditions.new("rules" => [rule("ticket.created_at", "gt", "2027-03-10 09:00")]).met?(values)
        assert Conditions.new("rules" => [rule("ticket.created_at", "lt", "2027-03-10 10:00")]).met?(values)
        assert_not Conditions.new("rules" => [rule("ticket.created_at", "gt", "later")]).met?(values)
      end
    end

    test "kept as a form sends them: numbered, without the rules that don't count, all unless any" do
      conditions = Conditions.new("match" => "any", "rules" => {"0" => rule("user.state", "is", "active"), "1" => rule("", "is", "x"), "2" => rule("user.name", "sounds_like", "x")})

      assert_equal({"match" => "any", "rules" => [{"variable" => "user.state", "operator" => "is", "value" => "active", "value_to" => ""}]}, conditions.to_h)
      assert_equal "all", Conditions.new("match" => "some").match
      assert Conditions.new(nil).empty?
      assert Conditions.new.met?({})
    end
  end
end
