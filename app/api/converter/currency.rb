# frozen_string_literal: true

module Converter
  class Currency < Grape::API
    version 'v1', using: :path
    format :json
    error_formatter :txt, lambda { |message, _backtrace, _options, _env, _original_exception|
      "staus: 'failed', message: #{message}, error_code: 123"
    }
    rescue_from :all

    helpers do
      def get_exchange_rate(currency)
        case currency
        when 'NTD'
          30
        else
          raise StandardError, "no conversion found #{currency}"
        end
      end
    end

    # /api/v1/converter/:method_name
    resource :converter do
      params do
        requires :amount, type: Float
        requires :to_currency, type: String
      end
      get :exchange do
        convertered_amount = params[:amount] *
                             get_exchange_rate(params[:to_currency])
        {
          amount: convertered_amount,
          currency: params[:to_currency]
        }
      end
    end
  end
end
