require 'test_helper'

class LineItemTest < ActiveSupport::TestCase

  product = Product.first
  order = Order.first

  test "should not save line item without quantity" do
    line_item = LineItem.new
    line_item.product_id = product.id
    line_item.order_id = order.id
    line_item.price = 99.99
    line_item.total = 99.99

    refute line_item.save
  end

  test "should not save line item without total" do
    line_item = LineItem.new
    line_item.product_id = product.id
    line_item.order_id = order.id
    line_item.price = 99.99
    line_item.quantity = 1

    refute line_item.save
  end

  test "should not save line item without order_id" do
    line_item = LineItem.new
    line_item.product_id = product.id
    line_item.quantity = 1
    line_item.price = 99.99
    line_item.total = 99.99

    refute line_item.save
  end

  test "should not save line item without product_id" do
    line_item = LineItem.new
    line_item.order_id = order.id
    line_item.quantity = 1
    line_item.price = 99.99
    line_item.total = 99.99

    refute line_item.save
  end

  test "should not save line item without price" do
    line_item = LineItem.new
    line_item.order_id = order.id
    line_item.product_id = product.id
    line_item.quantity = 1
    line_item.total = 99.99

    refute line_item.save
  end

  test "total should be equal to price * quantity" do
    line_item = LineItem.new
    line_item.product_id = product.id
    line_item.order_id = order.id
    line_item.quantity = 3
    line_item.price = 50.00
    line_item.total = 150.00

    assert line_item.save
    assert_equal line_item.total, line_item.quantity * line_item.price
  end
end
