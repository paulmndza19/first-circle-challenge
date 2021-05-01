module Promotions
  module Rules
    class BuyXGetY
      def self.call(promotion, line_item)
        @line_item = line_item
        @promotion = promotion

        return unless eligible?

        create_line_item
      end

      private

      def self.eligible?
        @line_item.quantity >= @promotion.buy
      end

      def self.create_line_item
        quantity = @line_item.quantity
        buy = @promotion.buy
        get = @promotion.get
        product = @line_item.product

        items_to_add = (quantity / buy) * get

        additional_line_item = LineItem.new
        additional_line_item.product = product
        additional_line_item.quantity = items_to_add
        additional_line_item.price = 0
        additional_line_item.total = 0
        additional_line_item.order = @line_item.order

        additional_line_item.save
      end
    end
  end
end