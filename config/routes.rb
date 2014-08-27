Rails.application.routes.draw do
  resources :users

  resources :wines

  resource :login

  root 'wines#index'

end
