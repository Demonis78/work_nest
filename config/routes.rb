Rails.application.routes.draw do
  devise_for :venue_admins, controllers: {
    registrations: 'venue_admins/registrations'
  }
  
  devise_scope :venue_admin do
    delete 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  resources :companies, only: [:new, :create]

  resources :venues do
    resources :offers, only: [:new, :create, :index, :show]
    resources :reservations, only: [:index, :new, :create, :destroy]
  end

  resources :offers, only: [:new, :create, :edit, :index, :show, :destroy] do
    resources :variants, only: [:new, :create, :destroy]
    member do
      post 'select_variant'
      delete 'remove_variant'
    end
    collection do
      get 'selected_variants'
    end
  end

  resources :variants, only: [] do
    resources :orders, only: [:new, :create, :show]
  end

  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
