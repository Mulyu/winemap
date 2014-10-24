Rails.application.routes.draw do

  devise_for :logininfos ,controllers: {
    registrations: 'logininfos/registrations'
  }
  resources :users
  resources :wines

  root 'wines#index'

  match 'mypage', to: 'users#info', via: :get
end
