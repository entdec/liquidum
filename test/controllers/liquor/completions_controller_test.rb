require 'test_helper'

module Liquidum
  class CompletionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should show message' do
      skip 'To be revised'

      get completions_url(q: 'form'), headers: { 'SERVER_NAME' => 'localhost' }
      assert_response :success

      h = {"q" => 'form', "completions" => ["to_liquid", "class_name", "model", "errors", "attribute"]}

      assert_equal h, JSON.parse(@response.body)
    end
  end
end
