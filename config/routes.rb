# -*- encoding : utf-8 -*-
RestyAtp::Application.routes.draw do
  ActiveAdmin.routes(self)
    
  devise_for :admin_users, ActiveAdmin::Devise.config
  
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
    get :nearby, :on => :member
    get :map, :on => :member
    get :blog_posts, :on => :collection
    get :pension_images, :on => :collection
    get :outlink, :on => :member
  end
  resources :spots do
    resources :pensions
    get :map, :on => :member
  end
  resources :areas do
    resources :pensions
    resources :spots
    resources :sub_areas
  end
  resources :sub_areas do
    resources :spots
    resources :pensions
  end
  resources :spots
  resources :contacts 
  #search
  match 'search/result' => 'search#result', :via => :post
  #api
  namespace :api do
    resources :pensions
  end
  # main
  match 'main' => 'main#index'
  root :to => 'main#index'
end
