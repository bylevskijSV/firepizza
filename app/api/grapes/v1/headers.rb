module Grapes
  module V1
    class Headers < Grape::API
      format :json

      namespace :headers do
        desc 'Return a header value.'
        params do
          requires :key, type: String
        end
        get ':key' do
          key = params[:key]
          { key => headers[key] }
        end

        desc 'Returns all headers'
        get do
          headers
        end
      end
    end
  end
end