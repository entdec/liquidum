class OrderLineDrop < Liquidum::Drop
  association :order, :product
  delegate :quantity, :kind, to: :@object

  describe :quantity, values: [1, 2, 3]
end
