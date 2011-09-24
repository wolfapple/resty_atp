# -*- encoding : utf-8 -*-
RestyAtp::Application.routes.draw do  
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
  #search'
  match 'search/autocomplete' => 'search#autocomplete'
  match 'search/result' => 'search#result'
  # main
  match 'main' => 'main#index'
  root :to => 'main#index'
end
