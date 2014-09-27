Rails.application.routes.draw do

  devise_for :logininfos

  resources :users

  resources :wines

  root 'wines#index'

end
