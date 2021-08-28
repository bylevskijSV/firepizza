require 'net/http'

class SendTelegramService < ApplicationService
  attr_reader :msg, :order_id

  def initialize(msg, order_id)
    @msg = msg
    @order_id = order_id
  end

  def call
    chat_ids = Rails.configuration.chat_ids
    token = Rails.application.credentials.telegram_token

    return unless token

    chat_ids.each do |chat_id|
      uri = URI("https://api.telegram.org/bot#{token}/sendMessage?")
      res = Net::HTTP.post_form(uri, 'chat_id' => chat_id.to_s, 'parse_mode' => 'html', 'text' => @msg)

      log_info(res, @order_id)
    end

  end

  def log_info(respond, order_id)
    logger = ActionController::Base.logger
    case respond
    when Net::HTTPOK
      logger.info { "Order #{order_id} successfully telegrammed" }
    when Net::HTTPBadRequest
      logger.error { "Order #{order_id} error caused by method sendMessage" }
    when Net::HTTPUnauthorized
      logger.error { 'Incorrect or outdated bot token' }
    else
      logger.fatal { "Return #{respond}" }
    end
  end
end