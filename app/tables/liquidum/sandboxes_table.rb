module Liquidum
  class SandboxesTable < ApplicationTable
    model Sandbox

    column(:context)
    column(:template)
    column(:description)
    column(:created_at)
    column(:updated_at)

    filter(:context) { |value| where('context ilike :query', query: "%#{value}%") }
    filter(:template) { |value| where('template ilike :query', query: "%#{value}%") }
    filter(:description) { |value| where('description ilike :query', query: "%#{value}%") }

    row_link { |sandbox| liquidum.edit_sandbox_path(sandbox) }

    private

    def scope
      @scope = Sandbox.all
    end
  end
end
