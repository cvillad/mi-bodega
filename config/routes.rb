Rails.application.routes.draw do
  root to: "home#index"
  get 'home/index'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    confirmations: "users/confirmations"
  }

  get "accounts/choose/:id", to: "accounts#choose", as: "choose_account"
  resources :boxes
  resources :accounts, except: [:new, :create]
  resources :members, except: [:edit, :update]
end
