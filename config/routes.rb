Rails.application.routes.draw do
  get '/parks', to: 'parks#index'
end
