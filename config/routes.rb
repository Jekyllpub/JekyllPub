Rails.application.routes.draw do
  root "sessions#new"
  post '/'        => "sessions#create"
  delete '/logout'    => "sessions#destroy"
  resources :users
  resources :articles
end
