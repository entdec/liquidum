# frozen_string_literal: true

module Liquidum
  # A variable a template can use, as the editor's variable picker shows it.
  # A variable with a drop has variables of its own; a collection is a list
  # of them, to loop over. A variable with values has those only, each
  # [{value, label}], for the editor to complete a comparison with it or a
  # where filter on it ({% if line.party == "sponsor" %}).
  Variable = Data.define(:name, :label, :type, :hint, :drop, :collection, :values) do
    def initialize(values: nil, **attributes)
      super
    end

    def as_json(*)
      {name: name, label: label, type: type, hint: hint, collection: collection, children: !drop.nil?, values: values}.compact
    end
  end
end
