Rails.application.routes.draw do
  devise_for :venue_admins, controllers: {
    registrations: 'venue_admins/registrations'
  }

  resources :companies, only: [:new, :create]

  resources :venues do
    resources :offers, only: [:new, :create, :index, :show]
  end

  resources :offers, only: [:index, :show, :new, :create] do
    resources :orders, only: [:create]
  end

  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
