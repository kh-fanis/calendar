Rails.application.routes.draw do
  root to: 'events#index'

  resources :events
  resources :messages, only: [:index, :new, :destroy, :create]

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index]
end
