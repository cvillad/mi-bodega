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
    patch "use/:id", to: "boxes/items#use", as: "item_use"
    patch "return/:id", to: "boxes/items#return", as: "item_return"
  end
  get "billing", to: "billing#index"
  resources :accounts, except: [:new, :create]
  patch "/accounts/select/:id", to: "accounts#select", as: "select_account"
  resources :members, except: [:edit, :update]
end
