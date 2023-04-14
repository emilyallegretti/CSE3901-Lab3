Rails.application.routes.draw do

  # Routes for reload_controller:

  #GET the empty form that allows the admin to specify what data gets reloaded into the database
  get 'reload/new', to: 'reload#new'

  # Use the form data to reload the database based on the specified parameters
  post 'reload', to: 'reload#reload_database'
  
  # auto-generated Devise routes.
  devise_for :users

  # CRUD routes for courses and their associated sections.
  resources :courses do
    resources :sections
  end
  # CRUD routes for status requests: this refers to new instructors and admins that are awaiting approval from existing admins. 
  resources :requests

  # CRUD routes for student application submissions and associated availabilities.
  resources :applications do
    resources :availabilities
  end
  # Custom route for the student application submission dashboard.
  get 'dashboard', to: 'applications#dashboard'

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