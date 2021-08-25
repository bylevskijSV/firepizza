# frozen_string_literal: true

module OrdersHelper
  def order_total(order)
    order.save(validate: false)
    order.total_for_pizzas
  end
end
