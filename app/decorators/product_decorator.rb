# frozen_string_literal: true

class ProductDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all

  def number_to_price
    number_to_currency(price, unit: 'BYN', precision: 0, format: '%n %u')
  end

  def number_to_weight
    number_to_currency(weight, unit: 'г', precision: 0, format: '%n %u')
  end
end
