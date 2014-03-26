Rent::Application.routes.draw do
  resources :renters

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users do
    collection do
      get 'for_assign/:role', action: :for_assign, as: :for_assign
    end
  end

end