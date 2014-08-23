Rails.application.routes.draw do
  resources :wines

  resource :login

  root 'home#home'

  match '/map', to: 'home#map',via: 'get'
  
end
