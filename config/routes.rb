Rails.application.routes.draw do

  resources :patients do
  
    member do
      get :delete
    end

  end

end
