Rails.application.routes.draw do
  root to: "home#index"
  get 'home/index'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    invitations: 'users/invitations'
  }

  resources :boxes do 
    resources :items, only: [:destroy, :new, :create, :update], controller: "boxes/items"
    get "move/:id", to: "boxes/items#move", as: "item_move"
  end
  get "billing", to: "billing#index"
  resources :accounts, except: [:new, :create]
  resources :members, except: [:edit, :update]
end
