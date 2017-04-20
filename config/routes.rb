Rails.application.routes.draw do
  devise_for :users
  resources :movies
  resources :infos
  resources :tickets
  resources :seances do
    collection do
      match 'search' => 'seances#search', via: [:get, :post], as: :search
    end
  end
  resources :orders do
    collection do
      match 'search' => 'orders#search', via: [:get, :post], as: :search
      get :show_info
      get :show_room
      get :summary
      get :update_ticket_type
      get :find
      get :timer_destroy
    end
  end
  resources :payments
  resources :seatings
  resources :rooms
  resources :users
  resources :categories
  root to: 'movies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
