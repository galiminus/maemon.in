Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'users#create'
  get "/signout" => "users#destroy", :as => :signout

  resources :users, only: [:show, :create, :update] do
    resources :metrics, only: [:show, :index, :create, :update, :destroy], module: :users
  end
  resource :user, controller: 'users'

  root to: "main#index"
end
