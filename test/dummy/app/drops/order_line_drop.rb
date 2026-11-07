class OrderLineDrop < Liquidum::Drop
  association :order, :product
  delegate :quantity, to: :@object
end
