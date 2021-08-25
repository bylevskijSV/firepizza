# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  # rubocop:disable Rails/OutputSafety
  def pagination(obj)
    raw(pagy_nav(obj)) if obj.pages > 1
  end
  # rubocop:enable Rails/OutputSafety

  def current_order
    if session[:order_id].nil?
      order = Order.new
      order.save(validate: false)
      session[:order_id] = order.id
      order
    else
      Order.find(session[:order_id])
    end
  end

  def full_title(page_title = '')
    base_title = 'FirePizza'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def order_items_size
    OrderItem.where(order_id: session[:order_id]).size
  end

  def cart_items
    OrderItem.where(order_id: session[:order_id]).order(:created_at)
  end

  def added_in_session_cart(product_id)
    session[:cart].push(product_id.to_i)
  end

  def remove_from_session_cart(product_id)
    session[:cart].delete(product_id.to_i)
  end
end
