S13::Application.routes.draw do

  get "settings/index"



  # Root
  root :to => "sessions#new"

  # Sign in and logout
  match "login" => "sessions#new", :as => "login"
  match "logout" => "sessions#destroy", :as => "logout"
  match "checkin" => "checkouts#to_be_checked_in", :as => "checkin"


  resources :sessions
  resources :users
  resources :territories
  resources :checkouts
  resources :publishers
  resources :territory_types
  resources :settings
  resources :worked_with_types
end