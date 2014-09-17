FactoryGirl.define do
  sequence :name do |n|
    "Test User #{n}"
  end
  
  sequence :email do |n|
    "test#{n}@example.com"
  end
  
  factory :user do
    name
    email
    password 'secret'
  end
end