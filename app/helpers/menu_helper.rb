# frozen_string_literal: true

module MenuHelper
  def all_full_row?(product)
    row_count(product) == row_count_ceil(product)
  end

  def row_count(product)
    product.count / quantity_in_a_row.to_f
  end

  def row_count_ceil(product)
    (product.count / quantity_in_a_row.to_f).ceil
  end

  def quantity_in_a_row
    Rails.configuration.quantity_in_a_row
  end

  def in_cart?(product_id)
    session[:cart].include?(product_id)
  end
end
