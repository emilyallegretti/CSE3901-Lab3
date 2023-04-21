# frozen_string_literal: true

Rails.application.routes.draw do
  # Routes for reload_controller:

  # GET the empty form that allows the admin to specify what data gets reloaded into the database
  get 'reload/new', to: 'reload#new'

  # Use the form data to reload the database based on the specified parameters
  post 'reload', to: 'reload#reload_database'

  # 2nd reload method, this uses only term code to reload the database
  post 'reload2', to: 'reload#reload_database2'

  # auto-generated Devise routes.
  devise_for :users

  # CRUD routes for courses and their associated sections.
  resources :courses do
    resources :sections
  end

  # CRUD routes for status requests: this refers to new instructors and admins that are awaiting approval from existing admins.
  resources :requests

  # CRUD routes for grader applications.
  resources :grader_applications do
    resources :availabilities
  end

  # CRUD routes for graders and their assigned sections.
  resources :grader_assignments

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
