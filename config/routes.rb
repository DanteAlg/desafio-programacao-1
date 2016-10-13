Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :delete]
  resources :purchases, only: [:index, :create]

  root to: 'purchases#index'
end
