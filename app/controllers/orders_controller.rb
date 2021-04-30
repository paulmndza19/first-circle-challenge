class OrdersController < ApplicationController
  def new
    load_products
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @line_items = order_params[:line_items_attributes]
  end

  private

  def load_products
    @products ||= Product.all
  end

  def order_params
    params.require(:order).permit(:customer_name, :customer_address, line_items_attributes: [:product_id, :quantity])
  end
end