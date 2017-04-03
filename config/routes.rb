Rails.application.routes.draw do
  get 'top_pages/index'
  root 'top_pages#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end
