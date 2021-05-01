module Orders::TestHelper
  def order_products_that_satisfies_all_promotions
    order_apple_tvs 3
    order_macbook 3
    order_ipad 5
  end

  def order_apple_tvs(quantity)
    add_line_item_field

    select 'Apple TV', from: 'order[line_items_attributes][0][product_id]'
    fill_in 'order[line_items_attributes][0][quantity]', with: quantity
  end

  def order_macbook(quantity)
    add_line_item_field

    select 'MacBook Pro', from: 'order[line_items_attributes][1][product_id]'
    fill_in 'order[line_items_attributes][1][quantity]', with: quantity
  end

  def order_ipad(quantity)
    add_line_item_field

    select 'Super iPad', from: 'order[line_items_attributes][2][product_id]'
    fill_in 'order[line_items_attributes][2][quantity]', with: quantity
  end

  def add_line_item_field
    find('.add_nested_fields_link').click
  end

  def submit
    find('input[name="commit"]').click
  end
end