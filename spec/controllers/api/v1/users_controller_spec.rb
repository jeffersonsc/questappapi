require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

	#Testing User controllers
	describe "GET #show" do
		before(:each) do
			@user = FactoryGirl.create :user
			get :show, id: @user.id, format: :json
		end

		it "Return the information abaout a reporter on a hash" do
			user_response = JSON.parse(response.body, symbolize_names: true)
			expect(user_response[:email]).to eql @user.email
		end

		it{expect(response).to have_http_status(200)}
	end
end
