Rails.application.routes.draw do
  resources :users
  root    'application#home', as: :root

  get     'signup' => 'users#new', as: :signup
  get     'login'  => 'logins#new', as: :login
  post    'login'  => 'logins#create', as: :login_create
  get     'logout' => 'logins#destroy', as: :logout
  get     'start'  => 'journeys#new', as: :journey_new
  post    'start'  => 'journeys#create', as: :journey_create
end
