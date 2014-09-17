Rails.application.routes.draw do
  root to: "projects#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :registrations, only: [:new, :create]
  resources :users
  resources :projects do
    resources :notes
  end
end
