# frozen_string_literal: true

class OrderItemsController < ApplicationController
  include OrderItemsHelper

  def create
    @order_item = OrderItem.create(order_item_params.merge(order_id: session[:order_id]))
    current_order.save(validate: false)
    added_in_session_cart(params[:order_item][:product_id])
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    remove_from_session_cart(@order_item.product_id)
    @order_item.destroy
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
