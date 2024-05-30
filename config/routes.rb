Rails.application.routes.draw do
  resources :companies, only: [:new, :create]

  devise_for :venue_admins, controllers: {
    registrations: 'venue_admins/registrations'
  }
  
  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check

   root "home#index"
end
