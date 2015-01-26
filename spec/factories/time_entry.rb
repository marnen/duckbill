FactoryGirl.define do
  factory :time_entry do
    user
    date { rand(10000).days.from_now }
    hours { rand(10000) * 0.01 }
    description { Faker::Lorem.sentence }
  end
end