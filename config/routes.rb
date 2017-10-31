Rails.application.routes.draw do
  resources :stops, only: [:index, :show]
end
