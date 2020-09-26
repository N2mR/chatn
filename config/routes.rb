Rails.application.routes.draw do

  
  
  resources :rooms, only: [:index, :show, :create, :destroy]
  resources :messages, only: [:index, :new, :create, :destroy]

  
  resources :relationships, only: [:create, :destroy]

  resources :users do
    get :search, on: :collection
    member do
      get :following
    end
  end

  root 'users#index'

  resources :sessions, only: [:new, :create, :destroy]

  get 'static_pages/timeline'
  get 'static_pages/friends'
  get 'static_pages/talk'
  get 'static_pages/settings'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
