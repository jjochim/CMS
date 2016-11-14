Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

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
  resources :users
  root to: 'movies#index'
  # get '/users/' => 'users#index', as: :users
  # patch '/users/:id/edit' => 'users#edit', as: :users_edit
  # post  '/users/new' => 'users#new', as: :users_new
  # get  '/users/:id', to:   'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
