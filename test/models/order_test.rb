require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "should not save order without customers name" do
    order = Order.new
    order.customer_address = 'Kattegat'
    order.total_price = 99.99

    refute order.save
  end

  test "should not save order without customers address" do
    order = Order.new
    order.customer_name = 'Ragnar Lothbrok'
    order.total_price = 99.99

    refute order.save
  end

  test "should not save order without total price" do
    order = Order.new
    order.customer_name = 'Ragnar Lothbrok'
    order.customer_address = 'Kattegat'

    refute order.save
  end

  test "order is saved when all fields are present" do
    order = Order.new
    order.customer_name = 'Ragnar Lothbrok'
    order.customer_address = 'Kattegat'
    order.total_price = 99.99

    assert order.save
  end
end
