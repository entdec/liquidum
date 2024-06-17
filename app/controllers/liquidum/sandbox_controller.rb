require_dependency "liquidum/application_controller"

module Liquidum
  class SandboxController < ApplicationController
    before_action :set_objects, except: %i[index]

    def index
    end

    def new
      render :edit
    end

    def create
      return render_only if params[:render_only] == "commit"

      @sandbox.update(sandbox_attributes)

      respond_with @sandbox,
        collection_location: -> { edit_sandbox_path(@sandbox) },
        action: :edit
    end

    def edit
      if @sandbox.valid?
        @sandbox.result = Liquidum.render(@sandbox.template, assigns: JSON.parse(@sandbox.context))
      end
    end

    def update
      return render_only if params[:render_only] == "commit"

      @sandbox.update(sandbox_attributes)

      respond_with @sandbox,
        collection_location: -> { edit_sandbox_path(@sandbox) },
        action: :edit
    end

    private

    def render_only
      @sandbox.assign_attributes(sandbox_attributes)

      if @sandbox.valid?
        @sandbox.result = Liquidum.render(@sandbox.template, assigns: JSON.parse(@sandbox.context))
      end
      render :edit, status: 302
    end

    def set_objects
      @sandbox = Sandbox.find(params[:id]) if params[:id]
      @sandbox ||= Sandbox.new(template: "{{test}}", context: '{"test": "context"}')
    end

    def sandbox_attributes
      params.require(:sandbox).permit(:context, :template, :description)
    end
  end
end
