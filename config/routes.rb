Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: 'home#index'
  resources :home, only: [:index]
  resources :work, only: [:index]
  resources :education, only: [:index]
  resources :dairy, only: [:index]
  resources :tech, only: [:index]
  resources :posts
  # Routes for '?post=id'
  get 'tech', to: 'tech#index', as: :tech_with_id
  get 'dairy', to: 'dairy#index', as: :dairy_with_id
  get '/login', to: 'session#login'
  delete '/logout', to: 'session#logout', as: :logout
  # Defines the root path route ("/")
  # root "posts#index"
end
