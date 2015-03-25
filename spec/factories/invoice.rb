FactoryGirl.define do
  factory :invoice do
    transient do
      user nil
    end

    association :client_version, factory: :version
    association :project_version, factory: :version
    association :user_version, factory: :version

    project

    after(:build) do |invoice, evaluator|
      user = evaluator.user
      if user
        invoice.project = FactoryGirl.create :project, user: user
      end
      invoice.capture_association_versions! if PaperTrail.enabled?
    end
  end
end