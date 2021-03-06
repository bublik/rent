Rent::Application.routes.draw do

  root :to => "renters#index"
  get "/about" => "home#about", via: [:get], :as => :about
  match "/administration" => "home#administration", via: [:get, :post], :as => :administration
  match "/send_renter" => "home#send_renter", via: [:get, :post], :as => :send_renter

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users do
    collection do
      get 'for_assign/:role', action: :for_assign, as: :for_assign
      post 'create', action: :create, as: :newaccount
      post 'search', action: :search, as: :search
    end
    #member do
    #  get 'edit', action: :edit, as: :editaccount
    #end
  end

  resources :renters do
    collection do
      get 'notify'
      get 'check_duplicate'
    end

    member do
      get 'grant_access/:user_id', action: :grant_access, as: :grant_access
      get 'publish/:time', action: :publish, as: :publish
    end
  end

  resources :orders
  resources :settings do
    collection do
      get 'for_assign/:role', action: :for_assign, as: :for_assign
    end

    member do
      get 'grant_access/:user_id', action: :grant_access, as: :grant_access
    end
  end

end