class ProductBulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_param)
    @archive = archive_param.tempfile
  end

  def call
    Zip::File.open(@archive) do |zip_file|
      zip_file.each do |entry|
        Product.import product_from(entry), ignore: true
      end
    end
  end

  private

  def product_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    sheet.map do |row|
      celss = row.cells
      Product.new name: celss[0].value,
                price: celss[1].value,
                ingredients: celss[2].value,
                description: celss[3].value,
                weight: celss[4].value,
                photo: celss[5].value,
                position: celss[6].value
    end
  end
end