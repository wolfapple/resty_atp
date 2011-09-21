# -*- encoding : utf-8 -*-
RestyAtp::Application.routes.draw do  
  get "password_resets/create"

  get "password_resets/edit"

  get "password_resets/update"

  # login, logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  # oauth
  resource :oauth do
    get :callback
  end
  match 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  # auth
  resources :users
  resources :user_sessions
  resources :password_resets
  #etc
  resources :pensions
  resources :pensions do
    resources :rooms
  end
  resources :themes do
    resources :pensions
  end
  resources :spots do
    resources :pensions
  end
  resources :spots
  resources :reviews
  # main
  match 'main' => 'main#index'
  root :to => 'main#index'
end
