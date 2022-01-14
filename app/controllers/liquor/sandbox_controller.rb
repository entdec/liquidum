require_dependency 'liquor/application_controller'

module Liquor
  class SandboxController < ApplicationController
    before_action :set_objects
    class Sandbox
      include ActiveModel::Model

      attr_accessor :template, :context, :result
    end

    def index; end

    def create
      @sandbox.result = Liquor.render(@sandbox.template,
                                      assigns: JSON.parse(@sandbox.context))
      render :index
    end

    private

    def set_objects
      @sandbox = Sandbox.new(template: params.dig(:sandbox_controller_sandbox, :template),
                             context: params.dig(:sandbox_controller_sandbox, :context), result: '')
    end
  end
end
