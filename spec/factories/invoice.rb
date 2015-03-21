FactoryGirl.define do
  factory :invoice do
    association :client_version, factory: :version
    association :project_version, factory: :version

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