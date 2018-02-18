S13::Application.routes.draw do

  get "settings/index"

  # Root
  root :to => "sessions#new"

  # Sign in and logout
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "check_in" => "checkouts#check_in", :as => "check_in"

  # Routes for the disable method in the checkouts, territories, territory_types, users, and worked_with_types controllers.
  get "co_disable" => "checkouts#disable", :as => "co_disable"
  get "co_enable" => "checkouts#enable", :as => "co_enable"
  get "ts_disable" => "territories#disable", :as => "ts_disable" 
  get "ts_enable" => "territories#enable", :as => "ts_enable" 
  get "tt_disable" => "territory_types#disable", :as => "tt_disable"
  get "tt_enable" => "territory_types#enable", :as => "tt_enable"
  get "ur_disable" => "users#disable", :as => "ur_disable"
  get "ur_enable" => "users#enable", :as => "ur_enable"
  get "ww_disable" => "worked_with_types#disable", :as => "ww_disable"
  get "ww_enable" => "worked_with_types#enable", :as => "ww_enable"
  get "cong_disable" => "congregations#disable", :as => "cong_disable"
  get "cong_enable" => "congregations#enable", :as => "cong_enable" 
  # Resources
  resources :sessions
  resources :users
  resources :territories
  resources :checkouts
  resources :territory_types
  resources :settings
  resources :worked_with_types
  resources :congregations
  resources :password_resets
end
