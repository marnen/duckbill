FactoryGirl.define do
  factory :client do
    user
    name { Faker::Name.name }
  end
end