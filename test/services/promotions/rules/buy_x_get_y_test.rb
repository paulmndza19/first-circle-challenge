module Promotions
  module Rules
    class BuyXGetYTest < ActiveSupport::TestCase
      setup do
        @promo = ProductsPromotion.find_by(promotion_rule: 'Promotions::Rules::BuyXGetY')
        create_order
      end

      test 'line item is added when quantity is satisfied' do
        create_line_item(3)

        assert_difference("@order.line_items.count") do
          Promotions::Rules::BuyXGetY.call(@promo, @line_item)
        end

        expected_quantity = (@line_item.quantity / @promo.buy) * @promo.get

        new_line_item = @order.line_items.last
        actual_quantity = new_line_item.quantity

        assert_equal expected_quantity, actual_quantity
      end

      test 'line item is added when quantity is not satisfied' do
        create_line_item(1)

        line_items_count = @order.line_items.count
        Promotions::Rules::BuyXGetY.call(@promo, @line_item)

        assert_equal line_items_count, @order.line_items.count
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
        @product = @promo.product

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
