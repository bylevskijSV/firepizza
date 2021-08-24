class API < Grape::API
  prefix 'api'
  format :json
  version 'v1', using: :path

  mount Grapes::V1::Pizzas
  mount Grapes::V1::Ping
  mount Grapes::V1::Headers

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status: e.status,
      error_msg: e.message,
    }.to_json, 400)
  end
end