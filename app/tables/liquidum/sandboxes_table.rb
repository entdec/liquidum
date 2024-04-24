module Liquidum
  class SandboxesTable < ApplicationTable
    definition do
      model Sandbox

      column(:description)
      column(:template)
      column(:created_at)
      column(:updated_at)

      # filter(:context) { |value| where("context ilike :query", query: "%#{value}%") }
      # filter(:template) { |value| where("template ilike :query", query: "%#{value}%") }
      # filter(:description) { |value| where("description ilike :query", query: "%#{value}%") }

      link { |sandbox| liquidum.edit_sandbox_path(sandbox) }
    end

    private

    def scope
      @scope = Sandbox.all
    end
  end
end
