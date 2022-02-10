Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :students
  get 'login', to: 'students#login'
  # get 'login', to: "sessions#new", as: 'students#login'
  resources :sessions, only: [:new, :create, :destroy]

end
