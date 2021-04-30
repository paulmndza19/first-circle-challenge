class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create

  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_address, line_items_attributes: [:product_id, :quantity])
  end
end