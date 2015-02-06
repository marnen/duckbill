FactoryGirl.define do
  trait :with_name_and_address do
    name { Faker::Name.name }
    company { Faker::Company.name }
    street { Faker::Address.street_address true }
    city { Faker::Address.city }
    state { Faker::AddressUS.state_abbr }
    zip { Faker::AddressUS.zip_code }
  end
end