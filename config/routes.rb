Rails.application.routes.draw do
  get 'instructors/home'
  root 'home#index'
  get 'home/about'

  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  devise_for :instructors, controllers: { registrations: 'instructors/registrations' }

  get '/admins', to: 'admins#home', as: :admin_root
  get '/instructors', to: 'instructors#home', as: :instructor_root
end