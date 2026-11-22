class OrderLine < ApplicationRecord
  belongs_to :order
  belongs_to :product

  attribute :kind, :string, default: "product"
  enum :kind, {product: "product", shipping: "shipping"}
end
