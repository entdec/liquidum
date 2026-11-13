module Liquidum
  # Try out Liquid: a template rendered with a JSON context, saved to come
  # back to
  class SandboxController < ApplicationController
    before_action :set_objects, except: %i[index]

    def index
    end

    def new
      render :edit
    end

    def create
      save
    end

    def edit
      render_result
    end

    def update
      save
    end

    private

    # "Render" shows the result without saving, "Save" saves and comes back
    def save
      @sandbox.assign_attributes(sandbox_attributes)
      return render_edit if params.key?(:render_only)

      if @sandbox.save
        redirect_to edit_sandbox_path(@sandbox), notice: t("liquidum.sandbox.saved")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def render_edit
      render_result
      render :edit, status: @sandbox.errors.any? ? :unprocessable_entity : :ok
    end

    def render_result
      return unless @sandbox.valid?

      @sandbox.result = Liquidum.render(@sandbox.template, assigns: @sandbox.assigns)
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
