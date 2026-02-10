Rails.application.routes.draw do
  devise_for :venue_admins, path: 'admin', controllers: {
    registrations: 'admin/registrations'
  }

  devise_scope :venue_admin do
    delete 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  namespace :admin do
    resources :companies, only: %i[new create]
    resources :offers, only: %i[new index create]

    resources :venues do
      resources :reservations, only: %i[index new create destroy]
      resources :offers, only: %i[new index create]
    end

    resources :offers, only: %i[create edit show update destroy] do
      resources :variants, only: %i[new edit create destroy show update]
      member do
        post 'select_variant'
        delete 'remove_variant'
      end
      collection do
        get 'selected_variants'
      end
    end

    get 'home/index'
    root 'home#index'
  end

  root 'home#index'

  resources :venues, only: %i[index show] do
    collection do
      post :search
      get :search
      get 'selected_variants'
    end
  end

  resources :cart, only: [:index] do
    collection do
      post :select_variant
      delete 'remove_variant/:variant_id', to: 'cart#remove_variant', as: 'remove_variant'
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
