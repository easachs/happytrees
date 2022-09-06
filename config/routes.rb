# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  resources :users, only: %i[show create]

  resources :parks do
    resources :trees, only: %i[index new create], controller: 'park_trees'
  end

  resources :trees, except: %i[new create]
end
