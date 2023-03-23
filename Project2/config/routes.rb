Rails.application.routes.draw do
  devise_for :users
  root 'data#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
 resources :courses

 get 'courses/reload', to: 'courses#reload'
#  get 'courses/reload', to: 'courses#reload'
end
