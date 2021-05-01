module Orders
  class UpdateTotal
    def self.call(order)
      line_items = order.line_items

      total_price = line_items.sum(&:total)
      order.total_price = total_price

      order.save
    end
  end
end