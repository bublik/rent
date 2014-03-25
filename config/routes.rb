Rent::Application.routes.draw do
  resources :renters

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

end