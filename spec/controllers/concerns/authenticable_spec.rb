require 'rails_helper'

=begin
class Authentication
	include Authenticable
end

describe Authenticable, :type => :controller do
	let(:authentication) { Authentication.new }

	describe "#current_user" do
		before do
			@user = FactoryGirl.create :user
			request.headers['Authorization'] = @user.auth_token
			allow(authentication).to receive(:request).and_return(request)
		end

		it "Return the user from the authorization header" do
			expect(authentication.current_user.auth_token).to eql @user.auth_token
		end
	end

	describe "#Authenticate_with_token" do
		before do
			@user = FactoryGirl.create :user
			allow(authentication).to receive(:current_user).and_return(nil)
			allow(response).to receive(:response_code).and_return(401)
			allow(response).to receive(:body).and_return({"errors" => "Not authenticated"}.to_json)
			allow(authentication).to receive(:response).and_return(response)
		end

		it "Render a json error message" do
			expect(json_response[:errors]).to eql "Not authenticated"
		end

		it { expect(response).to have_http_status(401) }
	end
end
=end