Wishlist::Application.routes.draw do
  root :to => "pages#home"

  match "/about",   :to => "pages#about"
  match "/help",    :to => "pages#help"
  match "/signup",  :to => "users#new"
  match "/login",   :to => "sessions#new"
  match "/logout",  :to => "sessions#destroy"

  resources :users, :sessions, :items

  match "/items/:id/claim" => "items#claim", :as => :claim
end
