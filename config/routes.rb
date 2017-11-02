Rails.application.routes.draw do
  root "stops#index"
  resources :stops, only: [:index, :show]
  namespace :api do
    namespace :v1 do
      resources :stops, only: [:index, :show]
    end
  end
end
