Rails.application.routes.draw do
  resources :users

  resources :wines

  resource :login

  root 'home#home'

  match '/map', to: 'home#map',via: 'get'
  
end
