FactoryGirl.define do
  factory :landing_page do
    email { FFaker::Internet.email }
  end
end
