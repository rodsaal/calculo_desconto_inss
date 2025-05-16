FactoryBot.define do
  factory :address do
    association :proponent
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
  end
end