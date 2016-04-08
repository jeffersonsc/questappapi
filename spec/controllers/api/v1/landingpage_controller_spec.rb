require 'rails_helper'

RSpec.describe Api::V1::LandingpageController, type: :controller do
	before(:each) {request.headers['Accept'] = "appication/vdn.questapp.v1"}

	describe "GET #show" do
		before(:each) do
			@user = FactoryGirl.create :landing_page
			get :show, id: @user.id.to_s, format: :json
		end

		it "return the information a about a reporter on a hash" do
			user_response = JSON.parse(response.body, symbolize_names: true)
			expect(user_response[:email]).to eql @user.email
		end

		it { expect(response).to have_http_status(200) }
	end

	describe "POST #create" do
		context "User has be created" do
			before(:each) do
				@user_attributes = FactoryGirl.attributes_for :landing_page
				post :create, {landing_page: @user_attributes}, format: :json
			end

			it "Render JSON after created successful" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eql @user_attributes[:email]
			end

			it { expect(response).to have_http_status(201) }
		end

		context "User not creted test when" do
			before(:each) do
				#create parmas without email
				@user_invalid_attributes = {email: ""}
				post :create, {landing_page: @user_invalid_attributes}, format: :json
			end

			it "Render json error" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

			it "Return error message to email" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:errors][:email]).to include "can't be blank"
			end

			it { expect(response).to have_http_status(422) }
		end
	end
end

