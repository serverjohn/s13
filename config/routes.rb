S13::Application.routes.draw do

  get "settings/index"

  # Root
  root :to => "sessions#new"

  # Sign in and logout
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "checkin" => "checkouts#to_be_checked_in", :as => "checkin"

  # Routes for the disable method in the checkouts, territories, territory_types, users, and worked_with_types controllers.
  get "ww_disable" => "checkouts#disable", :as => "co_disable"
  get "ts_disable" => "territories#disable", :as => "ts_disable" 
  get "tt_disable" => "territory_types#disable", :as => "tt_disable"
  get "ur_disable" => "users#disable", :as => "ur_disable"
  get "ww_disable" => "worked_with_types#disable", :as => "ww_disable"

  # Resources
  resources :sessions
  resources :users
  resources :territories
  resources :checkouts
  resources :publishers
  resources :territory_types
  resources :settings
  resources :worked_with_types
end
