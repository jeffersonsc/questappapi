require 'spec_helper'
require 'rails_helper'

RSpec.describe "LandingPage", type: :model do
  #Generate factory girl
  before {@user = FactoryGirl.build(:landing_page)}

  #Set user in context
  subject {@user}

  #Valid email not empty in landing page
  it {should respond_to(:email)}

  it {should be_valid}

end
