
class Order < ApplicationRecord
  include OrderText
  has_many :order_items, dependent: :destroy
  before_save :set_total
  before_update :set_confirmed_by, if: proc { confirmed_by? }

  # validate data
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
    order_items.sum { |order_item| get_order_price_item order_item }
  end

  def get_order_price_item(order_item)
    order_item.valid? ? order_item.total : 0
  end

  def confirmed_by?
    true unless name.nil?
  end

  private

  def set_confirmed_by
    self.confirmed_by = true
  end

  def set_total
    self.total_for_pizzas = order_total_price
  end
end
