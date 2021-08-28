# frozen_string_literal: true

class SendTelegramWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(msg, order_id)
    SendTelegramService.call msg, order_id
  end
end
