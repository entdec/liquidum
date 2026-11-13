require "test_helper"

module Liquidum
  class SandboxTest < ActiveSupport::TestCase
    test "the context gives the template's variables" do
      assert_equal({"name" => "Juliet"}, Sandbox.new(context: '{"name": "Juliet"}').assigns)
    end

    test "the context must be a JSON object" do
      assert Sandbox.new(template: "{{name}}", context: '{"name": "Juliet"}').valid?

      sandbox = Sandbox.new(template: "{{name}}", context: "[1, 2]")
      assert_not sandbox.valid?
      assert sandbox.errors.added?(:context, :not_a_json_object)

      sandbox = Sandbox.new(template: "{{name}}", context: "{name: Juliet}")
      assert_not sandbox.valid?
      assert_includes sandbox.errors.attribute_names, :context
      assert_equal({}, sandbox.assigns)
    end

    test "templates longer than a string column" do
      template = "{{ name }} " * 100
      sandbox = Sandbox.create!(template: template, context: "{}")

      assert_equal template, sandbox.reload.template
    end
  end
end
