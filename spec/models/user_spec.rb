require 'rails_helper'

RSpec.describe User, type: :model do
	before {@user = FactoryGirl.build(:user)}

	subject {@user}

	it{should respond_to(:email)}
	it{should respond_to(:password)}
	it{should respond_to(:password_confirmation)}
	it{should respond_to(:auth_token)}
	it{should respond_to(:name)}
	it{should respond_to(:nickname)}
	it{should respond_to(:birthdate)}
	it{should respond_to(:city)}
	it{should respond_to(:state)}
	it{should respond_to(:scores)}
	it{should respond_to(:imageurl)}

	it{should be_valid}

	describe "When user email is not present" do
		before {@user.email = ""}
		it {should_not be_valid}
	end


	it{should validate_presence_of(:email)}
	it{should validate_uniqueness_of(:email).case_insensitive}
	it{should validate_confirmation_of(:password)}
	it{should allow_value("exemple@domain.com").for(:email)}
	it{should validate_uniqueness_of(:auth_token)}

	it{should validate_presence_of(:name)}
	it{should validate_presence_of(:nickname)}
	it{should validate_uniqueness_of(:nickname)}
	it{should validate_presence_of(:birthdate)}
	it{should validate_presence_of(:city)}
	it{should validate_presence_of(:state)}
	it{should validate_presence_of(:scores)}
	it{should validate_numericality_of(:scores)}

	describe "#Generate authentication token!" do
		it "Generate a unique toekn" do
			allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
			@user.generate_authentication_token!
			expect(@user.auth_token).to eql "auniquetoken123"
		end

		it "Generate another token when one already has been token" do
			existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
			@user.generate_authentication_token!
			expect(@user.auth_token).not_to eql existing_user.auth_token
		end
	end

end
