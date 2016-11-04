Rails.application.routes.draw do
  devise_for :users
  resources :movies
  resources :infos
  resources :tickets
  resources :seances do
    collection do
      get :show_seances_with_movie
    end
  end
  resources :orders
  resources :seatings
  resources :rooms
  resources :categories
  root to: 'movies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
