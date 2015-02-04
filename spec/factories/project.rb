FactoryGirl.define do
  factory :project do
    transient do
      user nil
    end

    client
    name { Faker::Lorem.sentence }

    after(:build) do |project, evaluator|
      if evaluator.user
        project.client = FactoryGirl.create :client, user: evaluator.user
      end
    end
  end
end