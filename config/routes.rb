Rails.application.routes.draw do
  root "pages#index"
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
 # resources :listings
  resources :listings do
    resources :bookings
  end

  resources :bookings do
    resources :braintree, only: [:new]
  end

  resources :users, controller: "users" do
    resources :bookings
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "users/:id/username" => "users#username", as: "create_username"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "tags/:tag", to: "pages#index", as: :tag
  post 'braintree/checkout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
