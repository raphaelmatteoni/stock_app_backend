Rails.application.routes.draw do
  get '/stocks', to: 'stocks#index'
end