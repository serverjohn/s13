S13::Application.routes.draw do

  get "territory_types/index"
  get "territory_types/new"
  get "territory_types/edit"
  get "territory_types/show"
  get "territory_types/destroy"

  # Root
  root :to => "sessions#new"

  # Sign in and logout
  match "login" => "sessions#new", :as => "login"
  match "logout" => "sessions#destroy", :as => "logout"


  resources :sessions
  resources :users
  resources :territories
  resources :checkouts
  resources :publishers
  resources :territory_types
end
