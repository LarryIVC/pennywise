Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :expenses, only: [:index, :new, :create, :destroy]
    resources :groups, only: [:index, :new, :create, :destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'users_groups#index'
end
