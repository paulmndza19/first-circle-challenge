module Promotions
  module Rules
    class BulkPricing
      def self.call(promotion, line_item)
        @promotion = promotion
        @line_item = line_item

        return unless eligible?

        quantity = @line_item.quantity

        minimum_bulk_quantity = @promotion.minimum_bulk_quantity
        bulk_price = @promotion.bulk_price

        total = bulk_price * quantity

        @line_item.price = bulk_price
        @line_item.total = total
        @line_item.save
      end

      private

      def self.eligible?
        @line_item.quantity >= @promotion.minimum_bulk_quantity
      end
    end
  end
end