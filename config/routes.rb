Rails.application.routes.draw do

  get 'dashboard', to:"dashboard#index"

  namespace :admin do
    resources :templates
  end
  
  resources :reports do
    collection do
      get "templates"
    end
  end

  devise_for :users

  root "dashboard#index"
end
