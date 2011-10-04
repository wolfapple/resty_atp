# -*- encoding : utf-8 -*-
RestyAtp::Application.routes.draw do  
  # ActiveAdmin.routes(self)
    
  # devise_for :admin_users, ActiveAdmin::Devise.config
  
  # login, logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  # oauth
  resource :oauth do
    get :callback
  end
  match 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  # auth
  resources :user_sessions
  resources :password_resets
  #etc
  resources :users do
    get :map, :on => :member
  end
  resources :themes do
    resources :pensions
  end
  resources :pensions do
    resources :rooms
    get :update_like_count, :on => :collection
    get :update_comments_count, :on => :collection
  end
  resources :spots do
    resources :pensions
  end
  resources :areas do
    resources :pensions
  end
  resources :sub_areas do
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
