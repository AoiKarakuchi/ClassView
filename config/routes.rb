Rails.application.routes.draw do
  get "static_pages/home"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "static_pages#map"
  get "home", to: "static_pages#home"
  #root "static_pages#home"

  get "courses/by_term", to: "courses#by_term"
    get "map", to: "map#showMap"

  resources :user_regist_subjects do
    collection { post :import }
  end
  
  delete 'courses/delete_subject', to: 'courses#delete_subject'

end
