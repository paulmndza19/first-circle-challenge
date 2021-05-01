module Promotions
  module Rules
    class Freebies
      def initialize(promotion, line_item)
        @promotion = promotion
        @line_item = line_item
      end

      def call
        quantity = @line_item.quantity

        freebie_quantity_per_product = @promotion.freebie_quantity
        freebie_product_id = @promotion.freebie_product_id
        freebie_quantity = quantity * freebie_quantity_per_product

        freebies_line_item = LineItem.new
        freebies_line_item.product_id = freebie_product_id
        freebies_line_item.quantity = quantity
        freebies_line_item.total = 0
        freebies_line_item.order = line_item.order

        freebies_line_item.save
      end
    end
  end
end