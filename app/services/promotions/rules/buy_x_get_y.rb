module Promotions
  module Rules
    class BuyXGetY
      def self.call(promotion, line_item)
        @line_item = line_item
        @promotion = promotion

        return unless eligible?

        adjust_line_item
      end

      private

      def self.eligible?
        @line_item.quantity >= @promotion.buy
      end

      def self.adjust_line_item
        quantity = @line_item.quantity
        buy = @promotion.buy
        get = @promotion.get
        product = @line_item.product
        price = product.price

        divisor = buy + get

        priced_items_quantity = quantity - (quantity/divisor)
        free_items_quantity = priced_items_quantity / buy
        total = priced_items_quantity * price
        quantity = priced_items_quantity + free_items_quantity

        @line_item.quantity = quantity
        @line_item.total = total

        @line_item.save
      end
    end
  end
end