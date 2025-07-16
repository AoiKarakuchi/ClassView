Rails.application.routes.draw do
  root "static_pages#map"
  get "home", to: "static_pages#home"
  get "courses/by_term", to: "courses#by_term"
  get "map", to: "map#showMap"

  resources :user_regist_subjects do
    collection { post :import }
  end

  delete "courses/delete_subject", to: "courses#delete_subject"

  resources :memos, only: [ :create, :destroy ]
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get "up" => "rails/health#show", as: :rails_health_check
end
