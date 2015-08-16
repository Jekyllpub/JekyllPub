Rails.application.routes.draw do
	root "sessions#new"

  post '/'	=> "sessions#create"
  get 'login' => "sessions#new"
	delete 'logout' => "sessions#destroy"
	get 'signup' => "users#new"

	resources :users
  resources :articles
end