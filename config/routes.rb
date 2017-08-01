Rails.application.routes.draw do
  resources :users
  resources :posts do
    resources :comments, :likes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: 'logout'

  root 'welcome#index'
end
