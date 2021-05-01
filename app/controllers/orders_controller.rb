class OrdersController < ApplicationController
  def new
    load_products
    @order = Order.new
  end

  def create
    create_order
    create_line_items
    compute_order_total
  end

  private

  def create_order
    @order = Order.new
    @order.customer_name = order_params[:customer_name]
    @order.customer_address = order_params[:customer_address]
    @order.total_price = 0
    @order.save
  end

  def create_line_items
    line_items = order_params[:line_items_attributes]

    line_items.each do |k, attributes|
      LineItems::Create.call(@order, attributes)
    end
  end

  def compute_order_total
    line_items = @order.line_items
    Orders::ComputeTotal.call(line_items)
  end

  def load_products
    @products ||= Product.all
  end

  def order_params
    params.require(:order).permit(:customer_name, :customer_address, line_items_attributes: [:product_id, :quantity])
  end
end