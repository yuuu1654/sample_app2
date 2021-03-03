Rails.application.routes.draw do
	
	
	root 'static_pages#home'
	
	get '/help', to: 'static_pages#help'
	# => StaticPages#help
	
	get '/about', to: 'static_pages#about'
	
	get '/contact', to: 'static_pages#contact'
	# => contact_path '/contact'
	# => contact_url  'ドメイン名/contact'

	get '/signup', to: 'users#new'
	
	get '/login',     to: 'sessions#new'
	post '/login',    to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	
	resources :users do
		member do
			get :following, :followers
			# GET /users/1/following
			# GET /users/1/followers
		end
	end
	resources :account_activations, only: [:edit]
	resources :password_resets, only: [:new, :create, :edit, :update]
	resources :microposts, only: [:create, :destroy]
	resources :relationships, only: [:create, :destroy]
end

