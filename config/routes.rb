# -*- encoding : utf-8 -*-
Applebeauty::Application.routes.draw do
  devise_for :users

  #root :to => 'high_voltage/pages#show', :id => 'welcome'

  resources :links
  root :to => 'links#index'
end
