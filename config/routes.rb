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

  resources :boxes, except: [:edit, :update] do 
    resources :items, only: [:destroy, :new, :create, :update], controller: "boxes/items"
    get "move/:id", to: "boxes/items#move", as: "item_move"
  end
  get "billing", to: "billing#index"
  get "payment_method", to: "billing#edit", as: "edit_billing_information"
  patch "payment_method", to: "billing#update", as: "billing_information"
  resources :accounts, only: :index
  patch "/accounts/select/:id", to: "accounts#select", as: "select_account"
  resources :members, except: [:edit, :update]
end
