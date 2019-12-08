Rails.application.routes.draw do
  resources :users
  root "static_pages#home"
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
