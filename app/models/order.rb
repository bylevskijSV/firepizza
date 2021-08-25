# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  before_save :set_total

  validate data
  validates :name,
            presence: true,
            format: /[А-Яа-яЁё]/,
            length: { in: 3..40 },
            on: :update
  validates :phone,
            presence: true,
            format: /(\+375)(29|25|44|33)(\d{3})(\d{2})(\d{2})/,
            length: { is: 13 },
            numericality: { only_integer: true },
            on: :update
  validates :street,
            presence: true,
            format: /[А-Яа-яЁё]/,
            length: { in: 3..100 },
            on: :update
  validates :house_number, :subway_number, :apartment_number,
            presence: true,
            numericality: { only_integer: true },
            on: :update

  def order_total_price
    order_items.sum { |order_item| get_order_price_item(order_item) }
  end

  def get_order_price_item(order_item)
    order_item.valid? ? order_item.total : 0
  end

  def order_text
    message << order_info_to_string
    message << "-------------\n"
    message << order_product_to_string
    message << "-------------\n"
    message << "За всё: #{@order.total_for_pizzas} BYN"
  end

  def order_info_to_string
    message = "Информация о заказе: #{@order.id}\n"
    message << "-------------\n"
    message << "Имя: #{@order.name}\nТелефон: #{@order.phone}\n"
    message << "-------------\n"
    message << "Улица: #{@order.street}\n"
    message << "Номер дома: #{@order.house_number}\nНомер Подьезда:#{@order.subway_number}\n"
    message << "Номер квартиры:#{@order.apartment_number}\n"

    message << order_note_to_string
  end

  def order_note_to_string
    if @order.note.empty?
      "Примечания отсуствуют\n"
    else
      "Примечание: #{@order.note}\n"
    end
  end

  def order_product_to_string
    order_item_info = "Пиццы:\n"

    raise ActiveModel::Error.new(Order, :order_to_string, :too_short, count: 1) if @order.order_items.empty?

    @order.order_items.each do |item|
      order_item_info << "#{item.product.name}:#{item.quantity}\n"
    end

    order_item_info
  end

  def set_confirmed_by
    @order.confirmed_by = true
    @order.save
  end

  private

  def set_total
    self[:total_for_pizzas] = order_total_price
  end
end
