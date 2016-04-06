Rails.application.routes.draw do
  
  #Api definition using namespace set #api in controller
  #Format default of response :json
  #Set constraint of subdomain to api exemple api.example.com
  #Set path to root directory
  namespace :api, defaults: {format: :json}, constraints: {subdmain: :api}, path: '/' do
    #Set all routes types :get, :post, :put, :delete
    #Set version of Api /v1/contents
    scope module: :v1 do
      #Set routes in v1 api in folder #controllers/api/v1
    end
  end

end
