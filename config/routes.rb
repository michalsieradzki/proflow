Rails.application.routes.draw do
  devise_for :users
  
  # Theme toggle
  patch 'toggle_theme', to: 'theme#toggle'
  
  # Admin namespace
  namespace :admin do
    resources :users
    resources :static_pages
    
    # Dashboard jako osobna akcja
    get 'dashboard', to: 'static_pages#dashboard'
    
    root 'static_pages#dashboard'  # dashboard jako domyślna strona admin
  end
  
  # Public static pages (dla przyszłości)
  get '/pages/:slug', to: 'static_pages#show', as: :static_page
  
  # Główny root kieruje do admin dashboardu
  root 'admin/static_pages#dashboard'
  
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
