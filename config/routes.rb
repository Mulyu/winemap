Rails.application.routes.draw do
  resource :login

  root 'home#home'

  match '/map', to: 'home#map',via: 'get'
  
end
