Rails.application.routes.draw do
  resources :users
  resources :projects do
    resources :notes
  end
end
