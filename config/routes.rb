Rails.application.routes.draw do

  resources :users
  resources :attractions

  get "signin" => "users#signin"
  post "signin" => "users#new_session"
  get "logout" => "users#logout"

  post "attractions/:id/ride" => "attractions#ride"

  root "welcome#index"

end