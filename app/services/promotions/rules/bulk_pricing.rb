module Promotions
  module Rules
    class BulkPricing
      def initialize(promotion, line_item)
        @promotion = promotion
        @line_item = line_item
      end

      def call
        return unless eligible?

        quantity = @line_item.quantity

        minimum_bulk_quantity = @promotion.minimum_bulk_quantit
        bulk_price = @promotion.bulk_price

        total = bulk_price * quantity

        @line_item.total = total
        @line_item.save
      end

      private

      def eligible?
        @line_item.quantity >= @promotion.minimum_bulk_quantity
      end
    end
  end
end