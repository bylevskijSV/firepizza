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

  def set_order_data_collection
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

  def send_order_to_telegram
    message = set_order_data_collection
    chat_ids = Rails.configuration.chat_ids
    token = Rails.application.credentials.telegram_token
    # Если есть токен, отправить сообщение в телеграм-бот
    if token
      chat_ids.each do |chat_id|
        uri = URI("https://api.telegram.org/bot#{token}/sendMessage?")
        res = Net::HTTP.post_form(uri, 'chat_id' => chat_id.to_s, 'parse_mode' => 'html', 'text' => message)

        case res
        when Net::HTTPOK
          logger.info { "Order #{@order.id} successfully telegrammed" }
        when Net::HTTPBadRequest
          logger.error { "Order #{@order.id} error caused by method sendMessage" }
        when Net::HTTPUnauthorized
          logger.error { 'Incorrect or outdated bot token' }
        else
          logger.fatal { "Return #{res}" }
        end
      end
    end
  end

  def order_total
    @order = current_order
    @order.save(validate: false)
    @order.total_for_pizzas
  end
end
