module Promotions
  module Rules
    class BuyXGetYTest < ActiveSupport::TestCase
      setup do
        @promo = ProductsPromotion.find_by(promotion_rule: 'Promotions::Rules::BuyXGetY')
        create_order
      end

      test 'total price' do
        create_line_item(3)

        old_total = @line_item.total
        old_quantity = @line_item.quantity

        Promotions::Rules::BuyXGetY.call(@promo, @line_item)

        @line_item.reload

        product = @line_item.product
        price = product.price

        divisor = @promo.buy + @promo.get
        priced_quantity = old_quantity - (old_quantity / divisor)
        expected_total = price * priced_quantity
        new_total = @line_item.total

        refute_equal old_total, new_total
        assert_equal expected_total, new_total
      end

      test 'additional quantity' do
        create_line_item(5)

        old_quantity = @line_item.quantity

        Promotions::Rules::BuyXGetY.call(@promo, @line_item)

        @line_item.reload

        divisor = @promo.buy + @promo.get
        priced_quantity = old_quantity - (old_quantity / divisor)
        free_quantity = priced_quantity / @promo.buy
        expected_quantity = priced_quantity + free_quantity
        new_quantity = @line_item.quantity

        assert_equal expected_quantity, new_quantity
        refute_equal old_quantity, new_quantity
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
