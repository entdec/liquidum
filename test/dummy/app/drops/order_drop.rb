class OrderDrop < Liquidum::Drop
  association :customer, :order_lines
  delegate :number, :total, :placed_at, to: :@object

  describe :total, type: :money, hint: "Including VAT"
  describe :portal_url, label: -> { I18n.t("orders.portal_url") }

  def portal_url
    "https://www.example.com/orders/#{@object.id}"
  end

  def line(index)
    order_lines[index]
  end
end
