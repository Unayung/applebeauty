# -*- encoding : utf-8 -*-
Applebeauty::Application.routes.draw do
  devise_for :users do
    get "logout" => "devise/sessions#destroy"
  end
  #root :to => 'high_voltage/pages#show', :id => 'welcome'

  resources :links do
    resources :photos
    collection do
      get "best_of_the_week"
      get "best_of_the_month"
      get "worst_of_all"
      get "best_of_all"
      get "appeal"
    end
    member do
      post "like"
      post "dislike"
    end
  end

  root :to => 'links#index'
  mount Messenger::Bot::Space => "/webhook"
end
