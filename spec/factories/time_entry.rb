FactoryGirl.define do
  factory :time_entry do
    transient do
      user nil
    end

    project
    date { rand(10000).days.from_now }
    hours { rand(10000) * 0.01 }
    description { Faker::Lorem.sentence }

    after(:build) do |time_entry, evaluator|
      if evaluator.user
        time_entry.project = FactoryGirl.create :project, user: evaluator.user
      end
    end
  end
end