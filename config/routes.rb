Rails.application.routes.draw do
  resources :projects do
    member do
      get "add_subscriber"
      delete "remove_subscriber"
    end
  end

  resources :users, only: [:index] do
    member do
      get "give_user_admin"
      delete "revoke_user_admin"
    end
  end

  get "auth/login" => "auth#login"
  get "auth/logout" => "auth#logout"
  match "auth/:provider/callback" => "auth#callback", via: [:get, :post]
  get "auth/failure" => "auth#failure"

  root to: "projects#index"
end
