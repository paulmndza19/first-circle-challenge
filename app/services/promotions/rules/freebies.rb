module Promotions
  module Rules
    class Freebies
      def self.call(promotion, line_item)
        @promotion = promotion
        @line_item = line_item

        create_line_item
      end

      private

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