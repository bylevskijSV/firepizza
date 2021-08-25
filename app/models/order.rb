class Order < ApplicationRecord
  has_many :order_items
  before_save :set_total

  #validate data
  # validates :name,
  #           presence: true,
  #           format: /[А-Яа-яЁё]/,
  #           length: { in: 3..40 },
  #           on: :update
  # validates :phone,
  #           presence: true,
  #           format:  /(\+375)(29|25|44|33)(\d{3})(\d{2})(\d{2})/,
  #           length: { is: 13 },
  #           numericality: { only_integer: true },
  #           on: :update
  # validates :street,
  #           presence: true,
  #           format: /[А-Яа-яЁё]/,
  #           length: { in: 3..100 },
  #           on: :update
  # validates :house_number, :subway_number, :apartment_number,
  #           presence: true,
  #           numericality: { only_integer: true },
  #           on: :update

  def order_total_price
    order_items.map { |order_item| get_order_price_item(order_item) }.sum
  end

  def get_order_price_item(order_item)
    order_item.valid? ? order_item.total : 0
  end

  private
  def set_total
    self[:total_for_pizzas] = order_total_price
  end
end
