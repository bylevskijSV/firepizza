# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  mount API => '/'

  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create edit update]

  resources :menu, only: [:index]
  get 'delivery', to: 'deliveries#index'
  resource  :cart, only: [:show]
  resources :orders, only: %i[edit update]
  resources :order_items

  namespace :admin do
    resources :users, only: %i[index]
  end

  root 'home#index'
end
