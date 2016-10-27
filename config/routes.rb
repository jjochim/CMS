Rails.application.routes.draw do
  devise_for :users
  resources :movies
  resources :infos
  resources :order_tickets
  resources :order_seatings
  resources :tickets
  resources :seances
  resources :orders
  resources :seatings
  resources :rooms
  resources :category_movies
  resources :categories
  root to: 'movies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
