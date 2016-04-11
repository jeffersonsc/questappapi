Rails.application.routes.draw do
  
  devise_for :users
  #Creating routes to API
  namespace :api, defaults: {format: :json} do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
    end
  end
end
