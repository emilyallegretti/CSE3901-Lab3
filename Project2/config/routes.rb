Rails.application.routes.draw do
  get 'requests', to: 'requests#index'
  patch 'requests/:id', to: 'requests#update'
  get 'requests', to: 'requests#index'
  get 'reload/new', to: 'reload#new'
  post 'reload', to: 'data#home'
  
  # auto-generated Devise routes.
  devise_for :users

  # Defines the root path route ("/")
  # root "articles#index"
  resources :courses

  # Check if the user is signed in. If signed in, go to home page.
  # Else, go to sign in.
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
