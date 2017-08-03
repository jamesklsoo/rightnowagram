Rails.application.routes.draw do
  get 'braintree/new'

  post 'braintree/checkout'

  resources :users do
    resources :posts, except: [:index, :new, :create]
  end

  resources :posts, only: [:index, :new, :create]

  resource :session, only: [:create, :destroy, :new]

  resources :comments, only: [:create, :destroy, :update]

  get '/auth/:provider/callback', to: 'sessions#create_from_omniauth'

  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  root 'welcome#index'
end
