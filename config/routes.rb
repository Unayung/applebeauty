# -*- encoding : utf-8 -*-
Applebeauty::Application.routes.draw do
  devise_for :users

  #root :to => 'high_voltage/pages#show', :id => 'welcome'

  resources :links do
    member do
      get "like"
      get "dislike"
    end
  end

  root :to => 'links#index'
end
