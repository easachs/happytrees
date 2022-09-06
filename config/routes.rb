# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/parks', to: 'parks#index'
  get '/parks/new', to: 'parks#new'
  post '/parks', to: 'parks#create'
  get '/parks/:id', to: 'parks#show'
  get '/parks/:id/edit', to: 'parks#edit'
  patch '/parks/:id', to: 'parks#update'
  delete '/parks/:id', to: 'parks#destroy'

  get '/parks/:id/trees', to: 'park_trees#index'
  get '/parks/:id/trees/new', to: 'park_trees#new'
  post '/parks/:id/trees', to: 'park_trees#create'

  get '/trees', to: 'trees#index'
  get '/trees/:id', to: 'trees#show'
  get '/trees/:id/edit', to: 'trees#edit'
  patch '/trees/:id', to: 'trees#update'
  delete '/trees/:id', to: 'trees#destroy'
end
