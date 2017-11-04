Rails.application.routes.draw do
  resources :projects

  get "auth/login" => "auth#login"
  get "auth/logout" => "auth#logout"
  match "auth/:provider/callback" => "auth#callback", via: [:get, :post]
  get "auth/failure" => "auth#failure"

  root to: "projects#index"
end
