Rent::Application.routes.draw do

  root :to => "home#index"

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users do
    collection do
      get 'for_assign/:role', action: :for_assign, as: :for_assign
    end
  end

  resources :orders
  resources :renters do
    member do
      get 'grant_access/:user_id', action: :grant_access, as: :grant_access
    end
  end

end