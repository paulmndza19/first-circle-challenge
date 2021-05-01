module Promotions
  module Rules
    class BulkPricingTest < ActiveSupport::TestCase
      setup do
        @bulk_pricing_promo = ProductsPromotion.find_by(promotion_rule: 'Promotions::Rules::BulkPricing')
        create_order
      end

      test 'new price is implemented when quantity is satisfied' do
        create_line_item(5)

        previous_price = @product.price
        Promotions::Rules::BulkPricing.call(@bulk_pricing_promo, @line_item)

        @line_item.reload

        refute_equal previous_price, @line_item.price
        assert_equal @bulk_pricing_promo.bulk_price, @line_item.price
      end

      test 'new price is not implemented when quantity is not satisfied' do
        create_line_item(4)

        previous_price = @product.price
        Promotions::Rules::BulkPricing.call(@bulk_pricing_promo, @line_item)

        @line_item.reload

        assert_equal previous_price, @line_item.price
        refute_equal @bulk_pricing_promo.bulk_price, @line_item.price
      end

      private

      def create_order
        @order = Order.new
        @order.customer_name = 'Cade Cunningham'
        @order.customer_address = 'Orlando, Florida'
        @order.total_price = 0
        @order.save
      end

      def create_line_item(quantity)
        @product = @bulk_pricing_promo.product

        @line_item = @order.line_items.new
        @line_item.quantity = quantity
        @line_item.price =  @product.price
        @line_item.product = @product
        @line_item.total = LineItems::ComputeTotal.call(@product, @line_item)

        @line_item.save
      end
    end
  end
end
