Rails.application.routes.draw do
  devise_for :venue_admins, path: "admin", controllers: {
                              registrations: "admin/registrations",
                            }

  devise_scope :venue_admin do
    delete "logout", to: "devise/sessions#destroy", as: :logout
  end

  namespace :admin do
    resources :companies, only: [:new, :create]
    resources :offers, only: [:new, :index, :create]

    resources :venues do
      resources :reservations, only: [:index, :new, :create, :destroy]
      resources :offers, only: [:new, :index, :create]
    end

    resources :offers, only: [:create, :edit, :show, :update, :destroy] do
      resources :variants, only: [:new, :edit, :create, :destroy, :show, :update]
      member do
        post "select_variant"
        delete "remove_variant"
      end
      collection do
        get "selected_variants"
      end
    end

    get "home/index"
    root "home#index"
  end

  root "home#index"
  resources :venues, only: [] do
    collection do
      post :search
      get :search
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
