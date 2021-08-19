class OrdersController < ApplicationController
  include OrdersHelper
  helper_method :order_total
  before_action :set_order, only: [:edit, :update]

  def edit
  end

  def update
    if @order.update(order_params)
      set_confirmed_by
      send_order_to_telegram
      session.delete(:order_id)
      session.delete(:cart)
      render :confirm
    else
      render :edit, location: edit_order_path
    end
  end

  def confirm
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :street, :house_number, :subway_number, :apartment_number, :note)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
