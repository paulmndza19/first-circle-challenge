module LineItems
  class Create
    def self.call(order, line_item_attributes)
      @order = order
      @line_item_attributes = line_item_attributes

      set_product
      create_line_item

      @line_item
    end

    private

    def self.set_product
      id = @line_item_attributes[:product_id]
      @product = Product.find(id)
    end

    def self.create_line_item
      @line_item = @order.line_items.new
      @line_item.quantity = @line_item_attributes[:quantity]
      @line_item.price =  @product.price
      @line_item.product = @product
      @line_item.total = LineItems::ComputeTotal.call(@product, @line_item)

      @line_item.save
    end
  end
end