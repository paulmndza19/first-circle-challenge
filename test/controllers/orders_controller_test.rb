class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should render new page" do
    get new_order_path
    assert_response :success
  end

  test 'create new order with line items' do
    atv = Product.find_by(sku: 'atv')
    mbp = Product.find_by(sku: 'mbp')
    ipd = Product.find_by(sku: 'ipd')

    params = {
      order: {
        customer_name: 'Cade Cunningham',
        customer_address: 'Orlando, Florida',
        line_items_attributes: {
          '0': {
            product_id: atv.id, quantity: 3
          },
          '1': {
            product_id: mbp.id, quantity: 3
          },
          '2': {
            product_id: ipd.id, quantity: 5
          }
        }
      }
    }
    assert_difference("Order.count") do
      post orders_path, params: params
    end

    assert_redirected_to order_path(Order.last)
  end
end