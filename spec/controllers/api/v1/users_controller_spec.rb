require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

	#Testing User controllers - Endpoint Users
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

	describe "POST #create" do
		context "When user has be created" do
			before(:each) do
				@user_attr = FactoryGirl.attributes_for :user
				post :create, {user: @user_attr}, format: :json
			end

			it "Renders the json respresentation for the user record just created" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eql @user_attr[:email]
			end

			it{expect(response).to have_http_status(201)}
		end

		context "When user not created" do
			before(:each) do
				@user_invalid_attr = {password: "123456", password_confirmation: "123456"}
				post :create, {user: @user_invalid_attr}, format: :json
			end

			it "Renders an errors" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

			it "Render message user cloud not be create" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:errors][:email]).to include "can't be blank" 
			end

			it {expect(response).to have_http_status(422)}
		end
	end

	describe "PUT/PATCH #update" do
		context "When successfuly update" do
			before(:each) do
				@user = FactoryGirl.create :user
				patch :update, {id: @user.id,  user: {email: "teste@teste.com"}}, format: :json
			end

			it "Render json representation for the update user" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eql "teste@teste.com"
			end

			it{expect(response).to have_http_status(200)}
		end

		context "When is note create user" do
			before(:each) do
				@user = FactoryGirl.create :user
				patch :update, {id: @user.id, user: {email: "teste.com"}}
			end

			it "Renders an errors json" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

			it "Renders errors messages is invalid" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:errors][:email]).to include "is invalid"
			end

			it {expect(response).to have_http_status(422)}
		end
	end

end
