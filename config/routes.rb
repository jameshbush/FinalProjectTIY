Rails.application.routes.draw do
  root    'pages#home', as: :root
  get     'text-guide'  => 'pages#sms_guide',   as: :sms_guide
  get     'email-guide' => 'pages#email_guide', as: :email_guide

  get     'signup'    => 'users#new', as: :signup

  get     'login'  => 'logins#new', as: :login
  post    'login'  => 'logins#create', as: :login_create
  get     'logout' => 'logins#destroy', as: :logout

  get     'start'  => 'journeys#new', as: :journey_new
  post    'start'  => 'journeys#create', as: :journey_create

  post    'receive_sms'   => 'reports#create_from_sms'
  mount_griddler

  resources :users, only: [:new, :create, :edit, :update, :show] do
    member do
      get :confirm_email
    end
    resources :journeys, only: [:new, :create, :show] do
      resources :reports, only: [:new, :create, :update]
    end
  end
  resources :phone_verifications, only: [:new, :create]
end
