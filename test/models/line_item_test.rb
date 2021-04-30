require 'test_helper'

class LineItemTest < ActiveSupport::TestCase


  test "should not save line item without quantity" do
    line_item = LineItem.new
    line_item.product = products(:mbp)
    line_item.order = orders(:one)
    line_item.price = products(:mbp).price
    line_item.total = 1399.99

    refute line_item.save
  end

  test "should not save line item without total" do
    line_item = LineItem.new
    line_item.product = products(:mbp)
    line_item.order = orders(:one)
    line_item.price = products(:mbp).price
    line_item.quantity = 1

    refute line_item.save
  end

  test "should not save line item without order" do
    line_item = LineItem.new
    line_item.product = products(:mbp)
    line_item.quantity = 1
    line_item.price = products(:mbp).price
    line_item.total = 1399.99

    refute line_item.save
  end

  test "should not save line item without product" do
    line_item = LineItem.new
    line_item.order = orders(:one)
    line_item.quantity = 1
    line_item.price = products(:mbp).price
    line_item.total = 1399.99

    refute line_item.save
  end

  test "should not save line item without price" do
    line_item = LineItem.new
    line_item.product = products(:mbp)
    line_item.order = orders(:one)
    line_item.quantity = 1
    line_item.total = 1399.99

    refute line_item.save
  end

  test "total should be equal to price * quantity" do
    line_item = LineItem.new
    line_item.product = products(:mbp)
    line_item.order = orders(:one)
    line_item.quantity = 3
    line_item.price = products(:mbp).price
    line_item.total = 4199.97

    assert line_item.save
    assert_equal line_item.price, products(:mbp).price
    assert_equal line_item.total, line_item.quantity * line_item.price
  end
end
