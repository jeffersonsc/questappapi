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

		it { expect(response).to be_success }
	end
end
