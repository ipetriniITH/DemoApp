# Draw routes.
Rails.application.routes.draw do

  # Set root path.
  root 'patients#index'

  # Set admin path.
  get 'admin', to: 'access#menu'

  # Set paths to handle admin access.
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  resources :patients do  
    member do
      get :delete
    end
  end
end
