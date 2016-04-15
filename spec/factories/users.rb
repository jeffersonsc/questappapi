FactoryGirl.define do
  factory :user do
  	auxname = FFaker::NameBR.name
  	name auxname
  	nickname auxname.gsub(' ', '')
  	birthdate '14/05/1994'
  	city {FFaker::AddressBR.city}
  	state {FFaker::AddressBR.state}
  	imageurl {FFaker::Avatar.image}
    email {FFaker::Internet.email}
    password '12345678'
    password_confirmation '12345678'
  end
end
