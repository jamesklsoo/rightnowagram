Rails.application.routes.draw do

  resources :users, controller: "users" do
    resources :likes, controller: "likes"
    resources :posts, controller: "posts"
    resources :comments, controller: "comments"
  end

  resources :posts, controller: "posts" do
    resources :comments, controller: "comments", only: [:create, :new, :update, :destroy]
    resources :likes, controller: "likes"
    resources :buyings, controller: "buyings"
  end

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: 'logout'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/posts/payment/new" => "payment#new", as: "payment_new"
  post '/posts/payment/checkout' => "payment#checkout", as: "payment_checkout"
  root 'welcome#index'
end
