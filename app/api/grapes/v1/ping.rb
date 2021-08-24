module Grapes
  module V1
    class Ping < Grape::API
      desc 'Returns pong.'
      get :ping do
        { ping: params[:pong] || 'pong' }
      end
    end
  end
end