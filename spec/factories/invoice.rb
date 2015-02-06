FactoryGirl.define do
  factory :invoice do
    transient do
      user nil
    end

    project

    after(:build) do |invoice, evaluator|
      user = evaluator.user
      if user
        invoice.project = FactoryGirl.create :project, user: user
      end
    end
  end
end