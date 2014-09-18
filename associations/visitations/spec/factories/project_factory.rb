FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.words(3).join(' ') }
    description { Faker::Lorem.paragraphs(2).join("\n") }
  end
end