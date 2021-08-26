class UserBulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_param)
    @archive = archive_param.tempfile
  end

  def call
    Zip::File.open(@archive) do |zip_file|
      zip_file.each do |entry|
        User.import users_from(entry), ignore: true
      end
    end
  end

  private

  def users_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    sheet.map do |row|
      celss = row.cells
      User.new name: celss[0].value,
                email: celss[1].value,
                password: celss[2].value,
                password_confirmation: celss[2].value
    end
  end
end