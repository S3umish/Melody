Rails.application.routes.draw do
  root to: 'sessions#welcome'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/enrollments/most_expensive', to: 'enrollments#most_expensive', as: 'most_expensive'
  
  resources :users

  resources :enrollments

  resources :instruments  do
    resources :enrollments, only: [:new, :index, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
