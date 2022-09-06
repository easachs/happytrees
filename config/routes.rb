# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  resources :parks do
    resources :trees, only: %i[index new create], controller: 'park_trees'
  end

  resources :trees, except: %i[new create]
end
