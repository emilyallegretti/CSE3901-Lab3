Rails.application.routes.draw do
  devise_for :users
  resources :courses

  # Check if the user is signed in. If not signed in, go to login page.
  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'courses/reload', to: 'courses#reload'
end
