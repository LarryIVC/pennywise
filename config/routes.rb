Rails.application.routes.draw do
  # get 'pages/home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :users do
    resources :groups, only: [:index, :new, :create, :destroy] do
      resources :expenses, only: [:index, :new, :create, :destroy] 
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'pages#home'
  
end
