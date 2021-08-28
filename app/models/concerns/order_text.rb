module OrderText
  extend ActiveSupport::Concern

  included do

    def order_text
      message = order_info_to_string
      message << "-------------\n"
      message << order_product_to_string
      message << "-------------\n"
      message << "За всё: #{total_for_pizzas} BYN"
    end

    private

    def order_note_to_string
      if note.nil?
        "Примечания отсуствуют\n"
      else
        "Примечание: #{note}\n"
      end
    end

    def order_info_to_string
      message = "Информация о заказе: #{id}\n"
      message << "-------------\n"
      message << "Имя: #{name}\nТелефон: #{phone}\n"
      message << "-------------\n"
      message << "Улица: #{street}\n"
      message << "Номер дома: #{house_number}\nНомер Подьезда:#{subway_number}\n"
      message << "Номер квартиры:#{apartment_number}\n"

      message << order_note_to_string
    end

    def order_product_to_string
      order_item_info = "Пиццы:\n"

      raise ActiveModel::Error.new(Order, :order_to_string, :too_short, count: 1) if order_items.empty?

      order_items.each do |item|
        order_item_info << "#{item.product.name}:#{item.quantity}\n"
      end

      order_item_info
    end
  end
end