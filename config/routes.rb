Rails.application.routes.draw do
  
  #Creating routes to API
  namespace :api, defaults: {format: :json} do
    scope :v1 do
      
    end
  end
end
