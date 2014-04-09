Rent::Application.routes.draw do

  root :to => "renters#index"

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users do
    collection do
      get 'for_assign/:role', action: :for_assign, as: :for_assign
      post 'create', action: :create, as: :newaccount

    end
    #member do
    #  get 'edit', action: :edit, as: :editaccount
    #end
  end

  resources :renters do
    member do
      get 'grant_access/:user_id', action: :grant_access, as: :grant_access
      get 'publish/:time', action: :publish, as: :publish
    end
  end

  resources :orders
  resources :settings
end