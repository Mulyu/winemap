Rails.application.routes.draw do

  devise_for :logininfos ,controllers: {
    registrations: 'logininfos/registrations',
    sessions: 'logininfos/sessions'
  }
  resources :users do
    member do
      get :following,:followed
      post :follow,:remove
    end
  end

  resources :wines

  root 'wines#index'

  match 'mypage', to: 'users#mypage', via: :get

end
