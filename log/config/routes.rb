Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  devise_scope :user do
    get '/users/otp', to: 'sessions#redirect_to_sign_in'
    post '/users/otp', to: 'sessions#send_otp', as: 'send_otp'
  end

  # Defines the root path route ("/")
  # root "posts#index"
end 
