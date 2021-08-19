module OrdersHelper
  require 'net/http'

  def set_confirmed_by
    @order.confirmed_by = true
    @order.save
  end

  def order_to_string
    order_item_info = "Пиццы:\n"

    if !@order.order_items.empty?
      @order.order_items.each do |item|
        order_item_info << "#{item.product.name}:#{item.quantity}\n"
      end
    else
      ActiveModel::Error.new(Order, :order_to_string, :too_short, count: 1)
    end

    order_item_info
  end

  def order_text
    message = String.new("Информация о заказе: #{@order.id}\n")
    message << "-------------\n"
    message << "Имя: #{@order.name}\nТелефон: #{@order.phone}\n"
    message << "-------------\n"
    message << "Улица: #{@order.street}\n"
    message << "Номер дома: #{@order.house_number}\nНомер Подьезда:#{@order.subway_number}\n"
    message << "Номер квартиры:#{@order.apartment_number}\n"

    message <<
      if @order.note.empty?
        "Примечания отсуствуют\n"
      else
        "Примечание: #{@order.note}\n"
      end

    message << "-------------\n"
    message << order_to_string
    message << "-------------\n"
    message << "За всё: #{@order.total_for_pizzas} BYN"
  end

  def order_total
    @order = current_order
    @order.save(validate: false)
    @order.total_for_pizzas
  end
end
