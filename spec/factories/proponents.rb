FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    document { Faker::IDNumber.brazilian_citizen_number }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    inss_discount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end