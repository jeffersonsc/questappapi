Rails.application.routes.draw do
  
  devise_for :users
  #Creating routes to API
  namespace :api, defaults: {format: :json} do
    scope :v1 do
      
    end
  end
end
