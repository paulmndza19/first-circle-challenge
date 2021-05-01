module Promotions
  module Rules
    class FreebiesTest < ActiveSupport::TestCase
      setup do
        @promo = ProductsPromotion.find_by(promotion_rule: 'Promotions::Rules::Freebies')
        create_order
      end

      test 'line item is added when product has freebies' do
        mbp = Product.find_by(sku: 'mbp')
        create_line_item(mbp)

        assert_difference("@order.line_items.count") do
          Promotions::Rules::Freebies.call(@promo, @line_item)
        end

        expected_freebie_quantity = @line_item.quantity * @promo.freebie_quantity
        freebie_product = @promo.freebie_product

        new_line_item = @order.line_items.last
        actual_quantity = new_line_item.quantity

        assert_equal expected_freebie_quantity, actual_quantity
      end

      test 'line item is not added when product has no freebies' do
        vga = Product.find_by(sku: 'vga')
        create_line_item(vga)

        line_items_count = @order.line_items.count
        Promotions::Rules::Freebies.call(@promo, @line_item)

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

      def create_line_item(product)
        @product = @promo.product

        @line_item = @order.line_items.new
        @line_item.quantity = 3
        @line_item.price =  product.price
        @line_item.product = product
        @line_item.total = LineItems::ComputeTotal.call(@product, @line_item)

        @line_item.save!
      end
    end
  end
end
