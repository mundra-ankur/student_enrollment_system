Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'home#index'
  get 'home/about'
  get 'instructors/home'
  get 'instructors/index'
  get 'students/home'

  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  devise_for :instructors, controllers: { registrations: 'instructors/registrations' }
  devise_for :students, controllers: { registrations: 'students/registrations' }

  resources :instructors do
    resources :courses
  end

  get '/admins', to: 'admins#home', as: :admin_root
  get '/students', to: 'students#home', as: :student_root
  get '/instructors', to: 'instructors#index', as: :instructor_root
  resources :courses
end