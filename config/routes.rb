Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :menu, only: [:index]
  get 'delivery', to: 'deliveries#index'
  resource  :carts, only: [:show]
  resources :orders, only: [:edit, :update]
  resources :order_items
end
