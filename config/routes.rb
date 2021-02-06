Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  get '/help', to: 'static_pages#help'
  # => StaticPages#help
  
  get '/about', to: 'static_pages#about'
  
  get '/contact', to: 'static_pages#contact'
  # => contact_path '/contact'
  # => contact_url  'ドメイン名/contact'

  get '/signup', to: 'users#new'
  resources :users
  
end

