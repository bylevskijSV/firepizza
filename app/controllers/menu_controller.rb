# frozen_string_literal: true

class MenuController < ApplicationController
  include MenuHelper
  helper_method :row_count, :row_count_ceil, :all_full_row?, :between_borders?,
                :quantity_in_a_row, :second_border, :in_cart?

  def index
    @pagy, @pizzas = pagy Product.order(:position)
    @pizzas = @pizzas.decorate
    @order_item = current_order.order_items.new
  end
end
