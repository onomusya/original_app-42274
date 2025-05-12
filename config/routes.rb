Rails.application.routes.draw do
  get 'reservations/index'
  devise_for :users
  root to: "sites#index"

  resources :reservations, only: [:index, :new, :create]
end
