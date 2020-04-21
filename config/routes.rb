Rails.application.routes.draw do

  root 'patients#index'

  get 'admin', :to => 'access#menu'
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
