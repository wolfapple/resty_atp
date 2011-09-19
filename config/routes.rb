# -*- encoding : utf-8 -*-
RestyAtp::Application.routes.draw do
  get "rooms/index"

  get "spots/show"

  match '/main' => 'main#index'
  
  resources :pensions
  resources :pensions do
    resources :rooms
  end
  resources :theme do
    resources :pensions
  end
  resources :spots
  resources :reviews
  
  root :to => 'main#index'
end
