# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: %i[create]
  
  resources :parks do
    resources :trees, only: %i[index new create], controller: 'park_trees'
  end

  resources :trees, except: %i[new create]
end
