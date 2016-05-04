Rails.application.routes.draw do
  root    'application#home', as: :root

  get     'signup'    => 'users#new', as: :signup
  get     'dashboard' => 'users#show', as: :user_show

  get     'login'  => 'logins#new', as: :login
  post    'login'  => 'logins#create', as: :login_create
  get     'logout' => 'logins#destroy', as: :logout

  get     'start'  => 'journeys#new', as: :journey_new
  post    'start'  => 'journeys#create', as: :journey_create

  resources :users, only: [:new, :create, :show] do
    resources :journeys, only: [:new, :create, :show] do
      resources :reports, only: [:new, :create, :update]
    end
  end
end
