Rails.application.routes.draw do
  get '/upload', to: 'images#new'
  post '/upload', to: 'images#create'

  get 'sessions/new'

  get 'top_pages/index'
  root 'top_pages#index'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :images
end
