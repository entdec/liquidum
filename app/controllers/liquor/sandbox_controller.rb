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
      @sandbox = Sandbox.new(template: params[:template], context: params[:context], result: @result)
      @sandbox.result = Liquor.render(params[:template], assigns: params[:context]) if request.post?
      # FIXME: Use @sandbox in the view, with our regular form_with helper
      # Show @sandbox.result in the output, also in a textarea
    end
  end
end
