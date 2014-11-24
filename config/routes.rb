Rails.application.routes.draw do

  devise_for :logininfos ,controllers: {
    registrations: 'logininfos/registrations',
    sessions: 'logininfos/sessions'
  }
  resources :users ,except: [:new,:index] do
    member do
      get :following,:followed
      post :follow,:remove
    end
  end

  resources :wines, except: [:index]

  root 'wines#index'

  match 'mypage', to: 'users#mypage', via: :get
  match 'ranking', to: 'ranking#index', via: :get

  match 'inquiry', to: 'inquiry#index', via: :get
  match 'inquiry/confirm', to: 'inquiry#confirm', via: :post
  match 'inquiry/thanks', to: 'inquiry#thanks', via: :post

  match 'product', to: 'product#index', via: :get

end
