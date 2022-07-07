Rails.application.routes.draw do
  get '/parks', to: 'parks#index'
  get '/parks/:id', to: 'parks#show'
  get '/trees', to: 'trees#index'
  get '/trees/:id', to: 'trees#show'
end
