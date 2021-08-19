module MenuHelper
  def all_full_row?
    row_count == row_count_ceil
  end

  def row_count
    @pizzas.count / quantity_in_a_row.to_f
  end

  def row_count_ceil
    (@pizzas.count / quantity_in_a_row.to_f).ceil
  end

  def quantity_in_a_row
    Rails.configuration.quantity_in_a_row
  end

  def in_cart?(product_id)
    session[:cart].include?(product_id)
  end
end
