require "test_helper"

module Liquidum
  class SandboxControllerTest < ActionDispatch::IntegrationTest
    setup do
      @sandbox = Sandbox.create!(description: "Greeting", context: '{"name": "Juliet"}', template: "Hello {{ name }}")
    end

    test "the sandboxes" do
      get "/liquidum/sandbox"

      assert_response :success
      assert_select "*", text: /Liquid sandboxes/
    end

    test "a sandbox shows its template rendered" do
      get "/liquidum/sandbox/#{@sandbox.id}/edit"

      assert_response :success
      assert_includes response.body, "Hello Juliet"
    end

    test "render shows the result without saving" do
      patch "/liquidum/sandbox/#{@sandbox.id}", params: {render_only: "Render", sandbox: {template: "Bye {{ name }}", context: @sandbox.context}}

      assert_response :success
      assert_includes response.body, "Bye Juliet"
      assert_equal "Hello {{ name }}", @sandbox.reload.template
    end

    test "save saves and comes back to the sandbox" do
      assert_difference -> { Sandbox.count } do
        post "/liquidum/sandbox", params: {save: "Save", sandbox: {description: "Bye", template: "Bye {{ name }}", context: '{"name": "Romeo"}'}}
      end

      assert_redirected_to "/liquidum/sandbox/#{Sandbox.find_by!(description: "Bye").id}/edit"
    end

    test "a context that isn't JSON is shown, not raised" do
      patch "/liquidum/sandbox/#{@sandbox.id}", params: {save: "Save", sandbox: {template: @sandbox.template, context: "{name: Juliet}"}}

      assert_response :unprocessable_entity
      assert_equal '{"name": "Juliet"}', @sandbox.reload.context
    end

    test "Dutch" do
      I18n.with_locale(:nl) do
        get "/liquidum/sandbox/new"
      end

      assert_response :success
      assert_includes response.body, "Liquid-zandbak"
    end
  end
end
