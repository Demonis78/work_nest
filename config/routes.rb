Rails.application.routes.draw do
  devise_for :venue_admins, controllers: {
    registrations: 'venue_admins/registrations'
  }

  resources :companies, only: [:new, :create]
  resources :venues, only: [:index, :new, :create] do
    resources :offers, only: [:new, :create]
  end
    resources :offers, only: [:index, :show]


  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check

  root "offers#index"
end
