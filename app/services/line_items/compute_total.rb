module LineItems
  class ComputeTotal
    def self.call(product, line_item)
      price = product.price
      quantity = line_item.quantity

      price * quantity
    end
  end
end