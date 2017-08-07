FactoryGirl.define do
  factory :user do
    first_name "John123"
    last_name  "Doe"
    email "example123@example.com"
    password "secret"
    active "Y"
    congregation_id 1
    username "example123"
  end

  factory :territory_type do
  	active "Y"
  	name "Test Territory Type"
  end
 end

