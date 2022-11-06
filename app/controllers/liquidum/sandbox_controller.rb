require_dependency 'liquidum/application_controller'

module Liquidum
  class SandboxController < ApplicationController
    before_action :set_objects
    class Sandbox
      include ActiveModel::Model

      attr_accessor :template, :context, :result
    end

    def index; end

    def create
      @sandbox.result = Liquidum.render(@sandbox.template, assigns: JSON.parse(@sandbox.context))
      render :index
    end

    private

    def set_objects
      @sandbox = Sandbox.new(template: params.dig(:sandbox_controller_sandbox, :template) || '{{test}}',
                             context: params.dig(:sandbox_controller_sandbox,
                                                 :context) || '{"test": "context"}',
                             result: '')
    end
  end
end
