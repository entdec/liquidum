require_dependency "liquor/application_controller"

module Liquor
  class SandboxController < ApplicationController
    def index
      result = nil
      if request.post?
        result = Liquor.render(template_data, assigns: params[:assigns])
      end
    end
  end
end
