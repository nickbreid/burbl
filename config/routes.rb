Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'


  resources :stops, only: [:index, :show]
  resources :sessions, only: [:create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :stops, only: [:index, :show]
      get "current_user" => "users#current"
    end
  end

  root "stops#index"
end
