Rails.application.routes.draw do

  root 'patients#index'

  resources :patients do
  
    member do
      get :delete
    end

  end

end
