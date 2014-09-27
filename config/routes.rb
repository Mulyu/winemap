Rails.application.routes.draw do
  devise_for :logininfos
  resources :users

  resources :wines

  resource :login

  root 'wines#index'

end
