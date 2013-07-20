App::Application.routes.draw do
  root to: 'pages#home'

  # The API for client consumption.
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      match 'iphone', to: 'sessions#mobile', via: :post

      match 'account/create', to: 'sessions#create', via: :post
      match 'account/login', to: 'sessions#new', via: :post
      match 'account/check', to: 'sessions#check_username', via: :post

      match 'battles/index', to: 'battles#index', via: :get
      match 'battles/start', to: 'battles#start', via: :post
      match 'battles/attack', to: 'battles#attack', via: :post
      match 'battles/run', to: 'battles#run', via: :post
      match 'battles/item', to: 'battles#item', via: :post
      match 'battles/switch', to: 'battles#switch', via: :post

      match 'leaderboard/:category', to: 'leaderboard#index', via: :get
    end
  end

  # Everything below this comment is for www.
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

end
