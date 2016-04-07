class Api::V1::LandingpageController < ApplicationController
	respond_to :json

	def show
		respond_with LandingPage.find(params[:id])
	end
end
