FactoryGirl.define do
  factory :version, class: PaperTrail::Version do
    item_type { 'Dummy' }
    sequence(:item_id) {|n| n }
    event { 'Dummy' }
  end
end