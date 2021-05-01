module Promotions
  module Rules
    class BuyXGetY
      def initialize(promotion, line_item)
        @promotion = promotion
        @line_item = line_item
      end

      def call
        return unless eligible?

        quantity = @line_item.quantity
        buy = @promotion.buy
        get = @promotion.get
        product = @line_item.product
        price = product.price

        items_to_add = (quantity / buy) * get
        new_quantity = quantity + items_to_add

        @line_item.quantity = new_quantity
        @line_item.save
      end

      private

      def eligible?
        @line_item.quantity >= @promotion.buy
      end
    end
  end
end