Rails.application.routes.draw do
  
  get 'users/index'
  get 'users/sign_in'
  get 'users/sign_up'
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post "users/:id/update" => "users#update"
  get "users/new" => "users#new"
  get "users/:id/show" => "users#show"
  post "users/create" => "users#create"
  get "users/:id/account" => "users#account"
  get "users/:id/edit" => "users#edit"
  
  resources :users, only: [:show]
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' } 
  
  root 'users#index'
  resources :users
  resources :posts
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
