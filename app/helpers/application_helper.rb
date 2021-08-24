module ApplicationHelper

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      @order = Order.new
      @order.save(validate: false)
      session[:order_id] = @order.id
      @order
    end
  end

  def full_title(page_title = "")
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
