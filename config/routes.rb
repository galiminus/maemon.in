Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'users#create'
  get "/signout" => "users#destroy", :as => :signout

  resources :users, only: [:show, :index, :create, :update], constraints: { format: /json/ }  do
    resources :metrics, only: [:show, :index, :create, :update, :destroy]
    resources :relationships, only: [:show, :index, :create, :destroy]
  end
  resource :user, controller: 'users', constraints: { format: /json/ }

  get "*path", to: "main#index", constraints: { format: /html/ }

  root to: "pages#show", id: "home"
end
