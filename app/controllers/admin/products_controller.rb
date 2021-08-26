class Admin::ProductsController < ApplicationController
  before_action :require_authentication

  def index
    respond_to do |format|
      format.html do
        @pagy, @products = pagy Product.order(created_at: :desc)
      end

      format.zip { respond_with_zipped_products }
    end
  end

  def create
    ProductBulkService.call params[:archive] if params[:archive].present?

    redirect_to admin_products_path
  end

  private

  def respond_with_zipped_products
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      Product.order(created_at: :desc).each do |product|
        zos.put_next_entry "product_#{product.id}.xlsx"
        zos.print render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx],
          template: 'admin/products/product',
          locals: { product: product }
        )
      end
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: 'products.zip'
  end
end