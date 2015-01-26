FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password do
      1.upto(rand 8..20).collect do
        (Faker::String::WORD_CHARS + Faker::String::SPACES).shuffle.first
      end.join
    end
  end
end