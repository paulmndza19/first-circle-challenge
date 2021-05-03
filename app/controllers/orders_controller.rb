class OrdersController < ApplicationController
  def new
    load_products
    @order = Order.new
  end

  def create
    ActiveRecord::Base.transaction do
      create_order
      create_line_items
      apply_promotions
      compute_order_total
    end

    redirect_to @order, notice: 'Order was successfully created.'
  end

  def show
    load_order
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
    line_item_params = order_params[:line_items_attributes]
    line_items = LineItems::BuildParams.call(line_item_params)

    line_items.each do |line_item|
      LineItems::Create.call(@order, line_item)
    end
  end

  def compute_order_total
    @order.reload
    Orders::UpdateTotal.call(@order)
  end

  def apply_promotions
    line_items = @order.line_items

    line_items.each do |line_item|
      product = line_item.product
      LineItems::ComputePromotion.call(product, line_item)
    end
  end

  def load_products
    @products ||= Product.all
  end

  def load_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_name, :customer_address, line_items_attributes: [:product_id, :quantity])
  end
end