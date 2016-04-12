require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
	describe "POST #create" do
		before(:each) do
			@user = FactoryGirl.create :user
		end

		context "when the credentials are correct" do
			before(:each) do
				credential = {email: @user.email, password: "12345678"}
				post :create, {session: credential}
			end

			it "Return the user record corresponding to the given credential" do
				@user.reload
				expect(json_response[:auth_token]).to eql @user.auth_token
			end

			it {expect(response).to have_http_status(200)}
		end

		context "When invalid credentials" do
			before(:each) do
				credential = {email: @user.email, password: "invalidpassword"}
				post :create, {session: credential}
			end

			it "Return error message authentication" do
				expect(json_response[:errors]).to eql "Invalid email or password"
			end

			it {expect(response).to have_http_status(401)}
		end
	end

end
