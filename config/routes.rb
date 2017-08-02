Rails.application.routes.draw do
  resources :users
  resources :posts do
    resources :comments, :likes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'signup' => 'users#new'
  get '/signin' => 'sessions#new', as: 'signin'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: 'logout'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  root 'welcome#index'
end
