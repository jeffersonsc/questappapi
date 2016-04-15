require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
	
	#Testing User controllers - Endpoint Users
	describe "GET #show" do
		before(:each) do
			@user = FactoryGirl.create :user
			api_authirization_header @user.auth_token
			get :show, id: @user.id, format: :json
		end

		it "Return the information abaout a reporter on a hash" do
			expect(json_response[:email]).to eql @user.email
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
				expect(json_response[:email]).to eql @user_attr[:email]
				expect(json_response[:name]).to eql	@user_attr[:name]
				expect(json_response[:nickname]).to eql	@user_attr[:nickname]
				expect(json_response[:birthdate]).to eql	'1994-05-14'
				expect(json_response[:city]).to eql	@user_attr[:city]
				expect(json_response[:state]).to eql	@user_attr[:state]
			end

			it{expect(response).to have_http_status(201)}
		end

		context "When user not created" do
			before(:each) do
				@user_invalid_attr = {password: "123456", password_confirmation: "123456"}
				post :create, {user: @user_invalid_attr}, format: :json
			end

			it "Renders an errors" do
				expect(json_response).to have_key(:errors)
			end

			it "Render message user can't be create" do
				expect(json_response[:errors][:email]).to include "can't be blank" 
			end

			it {expect(response).to have_http_status(422)}
		end
	end

	describe "PUT/PATCH #update" do
		context "When successfuly update patch" do
			before(:each) do
				@user = FactoryGirl.create :user
				api_authirization_header @user.auth_token
				patch :update, {id: @user.id,  user: {email: "teste@teste.com", name: "Maria"}}, format: :json
			end

			it "Render json representation for the update user" do
				expect(json_response[:email]).to eql "teste@teste.com"
				expect(json_response[:name]).to eql "Maria"
			end

			it{expect(response).to have_http_status(200)}
		end

		context "When is note create user patch" do
			before(:each) do
				@user = FactoryGirl.create :user
				api_authirization_header @user.auth_token
				patch :update, {id: @user.id, user: {email: "teste.com"}}
			end

			it "Renders an errors json" do
				expect(json_response).to have_key(:errors)
			end

			it "Renders errors messages is invalid" do
				expect(json_response[:errors][:email]).to include "is invalid"
			end

			it {expect(response).to have_http_status(422)}
		end

		context "When successfuly update put" do
			before(:each) do
				@user = FactoryGirl.create :user
				api_authirization_header @user.auth_token
				put :update, {id: @user.id,  user: {email: "teste2@teste.com", password: "12345678910", password_confirmation: "12345678910"}}, format: :json
			end

			it "Render json representation for the update user" do
				expect(json_response[:email]).to eql "teste2@teste.com"
			end

			it{expect(response).to have_http_status(200)}
		end

		context "When is note create user put" do
			before(:each) do
				@user = FactoryGirl.create :user
				api_authirization_header @user.auth_token
				put :update, {id: @user.id, user: {email: "teste.com", password: "1234", password_confirmation: "1234"}}
			end

			it "Renders an errors json" do
				expect(json_response).to have_key(:errors)
			end

			it "Renders errors messages is invalid" do
				expect(json_response[:errors][:email]).to include "is invalid"
			end

			it {expect(response).to have_http_status(422)}
		end
	end

	describe "DELETE #destroy" do
		before(:each) do
			@user = FactoryGirl.create :user
			api_authirization_header @user.auth_token
			delete :destroy, {id: @user.id}, format: :json
		end

		it{expect(response).to have_http_status(204)}
	end

end
