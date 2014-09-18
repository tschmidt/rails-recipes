FactoryGirl.define do
  factory :note do
    content { Faker::Lorem.paragraphs(3).join("\n") }
    user
    project
  end
end