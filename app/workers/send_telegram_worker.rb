require 'net/http'

class SendTelegramWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(msg, order_id)
    chat_ids = Rails.configuration.chat_ids
    token = Rails.application.credentials.telegram_token

    if token
      chat_ids.each do |chat_id|
        uri = URI("https://api.telegram.org/bot#{token}/sendMessage?")
        res = Net::HTTP.post_form(uri, 'chat_id' => chat_id.to_s, 'parse_mode' => 'html', 'text' => msg)

        case res
        when Net::HTTPOK
          logger.info { "Order #{order_id} successfully telegrammed" }
        when Net::HTTPBadRequest
          logger.error { "Order #{order_id} error caused by method sendMessage" }
        when Net::HTTPUnauthorized
          logger.error { 'Incorrect or outdated bot token' }
        else
          logger.fatal { "Return #{res}" }
        end
      end
    end
  end
end
