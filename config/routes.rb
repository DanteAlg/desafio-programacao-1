Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :registrations, only: [:new, :create]
  resources :purchases, only: [:index, :create]

  root to: 'purchases#index'
end
