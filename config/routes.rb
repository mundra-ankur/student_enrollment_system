Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  get 'home/about'
  get '/admins', to: 'admins#home', as: :admin_root
end
