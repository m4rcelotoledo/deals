# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to:'deals#index'

  resources :deals do
    member do
      post 'won'
      post 'lost'
    end
  end
end
