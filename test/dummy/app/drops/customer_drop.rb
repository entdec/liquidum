class CustomerDrop < Liquidum::Drop
  association :orders
  delegate :name, :email, to: :@object
end
