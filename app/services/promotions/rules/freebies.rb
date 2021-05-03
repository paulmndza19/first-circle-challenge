module Promotions
  module Rules
    class Freebies
      def self.call(promotion, line_item)
        @promotion = promotion
        @line_item = line_item

        return unless eligible?

        order_has_freebie_product? ? adjust_freebie_product : create_line_item
      end

      private

      def self.eligible?
        @line_item.product == @promotion.product
      end

      def self.order_has_freebie_product?
        freebie_product = @promotion.freebie_product
        order = @line_item.order

        order.line_items.where(product: freebie_product).exists?
      end

      def self.adjust_freebie_product
        freebie_product = @promotion.freebie_product
        order = @line_item.order

        freebie_product_line_item = order.line_items.find_by(product: freebie_product)

        return if freebie_product_line_item.nil?

        freebie_quantity = freebie_product_line_item.quantity
        product_quantity = @line_item.quantity

        if product_quantity >= freebie_quantity
          freebie_product_line_item.update!(quantity: product_quantity, total: 0, price: 0)
        else
          priced_quantity = freebie_quantity - product_quantity
          total = priced_quantity * freebie_product_line_item.price

          debugger

          freebie_product_line_item.update!(total: total)
        end

      end

      def self.create_line_item
        quantity = @line_item.quantity

        freebie_quantity_per_product = @promotion.freebie_quantity
        freebie_product_id = @promotion.freebie_product_id
        freebie_quantity = quantity * freebie_quantity_per_product

        freebies_line_item = LineItem.new
        freebies_line_item.product_id = freebie_product_id
        freebies_line_item.quantity = freebie_quantity
        freebies_line_item.price = 0
        freebies_line_item.total = 0
        freebies_line_item.order = @line_item.order

        freebies_line_item.save
      end
    end
  end
end