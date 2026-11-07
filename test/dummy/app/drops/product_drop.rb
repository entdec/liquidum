class ProductDrop < Liquidum::Drop
  delegate :name, to: :@object
end
