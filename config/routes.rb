# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  resources :users, only: %i[show create]

  resources :parks do
    resources :trees, only: %i[index new create], controller: 'park_trees'
  end

  resources :trees, except: %i[new create]
end
