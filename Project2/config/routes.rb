Rails.application.routes.draw do
  devise_for :users
  resources :courses

  root to: "home#index"
  get 'courses/reload', to: 'courses#reload'
end
