require_dependency 'liquor/application_controller'

module Liquor
  class SandboxController < ApplicationController
    class Sandbox
      include ActiveModel::Model

      def initialize(attributes = {})
        attributes.each do |attr, _value|
          # Setter
          define_singleton_method("#{attr}=") { |val| attributes[attr] = val }
          # Getter
          define_singleton_method(attr) { attributes[attr] }
        end
      end
    end

    def index
      @sandbox = Sandbox.new(template: params[:template], context: params[:context])
      result = nil
      result = Liquor.render(params[:template], assigns: params[:context]) if request.post?
    end
  end
end
