Rails.application.routes.draw do
  get '/parks', to: 'parks#index'
  get '/trees', to: 'trees#index'
end
