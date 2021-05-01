require "application_system_test_case"
require "helpers/orders/test_helper"

class OrdersTest < ApplicationSystemTestCase
  include Orders::TestHelper

  setup do
    visit 'orders/new'

    @customer_name = 'Cade Cunningham'
    @customer_address = 'Orlando, Florida'

    assert_selector 'h3', text: 'New Order'
    fill_in 'order[customer_name]', with: @customer_name
    fill_in 'order[customer_address]', with: @customer_address
  end

  test 'create an order that satisfies all promotion rules' do
    order_products_that_satisfies_all_promotions

    submit

    assert_selector '#customer-name', text: "Customer Name: #{@customer_name}"
    assert_selector '#customer-address', text: "Customer Address: #{@customer_address}"

    assert page.has_content? 'Apple TV (109.5)'
    assert page.has_content? 'Apple TV (0.0)'
    assert page.has_content? 'MacBook Pro (1399.99)'
    assert page.has_content? 'VGA adapter (0.0)'
    assert page.has_content? 'Super iPad (499.99)'
    assert page.has_content? '$7,028.42'

    order = Order.last

    assert_equal 7028.42.to_d, order.total_price
  end
end
