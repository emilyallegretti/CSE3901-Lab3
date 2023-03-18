Rails.application.routes.draw do
<<<<<<< HEAD
 root 'data#home'
=======
  devise_for :users
>>>>>>> origin/devise_login
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
 resources :courses

 get 'courses/reload', to: 'courses#reload'
end
