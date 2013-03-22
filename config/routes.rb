# -*- encoding : utf-8 -*-
Applebeauty::Application.routes.draw do
  devise_for :users

  #root :to => 'high_voltage/pages#show', :id => 'welcome'

  resources :links do
    collection do
      get "best_of_the_week"
      get "best_of_the_month"
    end
    member do
      get "like"
      get "dislike"
    end
  end

  root :to => 'links#index'
end
