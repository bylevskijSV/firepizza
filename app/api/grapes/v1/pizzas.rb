# frozen_string_literal: true

module Grapes
  module V1
    class Pizzas < Grape::API
      resources :menu do
        desc 'Return all pizzas'
        get do
          Product.all
        end

        desc 'Return specific pizza'
        route_param :id, type: Integer do
          get :find do
            Product.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            error!('Record Not Found', 404)
          end
        end
      end
    end
  end
end
