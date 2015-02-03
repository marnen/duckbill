FactoryGirl.define do
  factory :project do
    client
    name { Faker::Lorem.sentence }
  end
end