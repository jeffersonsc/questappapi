class Api::V1::LandingPagesController < ApplicationController
	respond_to :json

	def show
		respond_with LandingPage.find(params[:id])
	end

	def create
		landingpage = LandingPage.new(landing_page_params)
		if landingpage.save
			render json: landingpage, status: 201 , location: [:api, landingpage]
		else
			render json: {errors: landingpage.errors}, status: 422
		end
	end

	private
	def landing_page_params
		params.require(:landing_page).permit(:email)
	end
end
