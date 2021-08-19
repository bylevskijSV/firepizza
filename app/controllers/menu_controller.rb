class MenuController < ApplicationController
  include MenuHelper
  helper_method :row_count, :row_count_ceil, :all_full_row?, :between_borders?,
                :quantity_in_a_row, :second_border, :in_cart?

  def index
    @pizzas = Product.order(:position)
    @order_item = current_order.order_items.new
    @f_border = 1
    @s_border = quantity_in_a_row
  end

end
