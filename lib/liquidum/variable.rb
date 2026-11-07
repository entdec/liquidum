# frozen_string_literal: true

module Liquidum
  # A variable a template can use, as the editor's variable picker shows it.
  # A variable with a drop has variables of its own; a collection is a list
  # of them, to loop over.
  Variable = Data.define(:name, :label, :type, :hint, :drop, :collection) do
    def as_json(*)
      {name: name, label: label, type: type, hint: hint, collection: collection, children: !drop.nil?}.compact
    end
  end
end
