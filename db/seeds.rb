require 'faker'

puts "Limpando registros..."
Proponent.destroy_all
Address.destroy_all
Contact.destroy_all

puts "Criando proponentes..."

100.times do
  salary = case rand(1..4)
           when 1 then rand(800.0..1412.0)       # faixa 1
           when 2 then rand(1412.01..2666.68)    # faixa 2
           when 3 then rand(2666.69..4000.03)    # faixa 3
           when 4 then rand(4000.04..7786.02)    # faixa 4
           end

  proponent = Proponent.create!(
    name: Faker::Name.name,
    document: Faker::IdNumber.brazilian_citizen_number(formatted: true),
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 70),
    salary: salary,
    inss_discount: InssCalculatorService.new(salary).calculate
  )

  proponent.addresses.create!(
    street: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code
  )

  contact_type = %w[email celular whatsapp residencial].sample

  value =
    if contact_type == "email"
      Faker::Internet.email
    else
      Faker::PhoneNumber.cell_phone
    end

  proponent.contacts.create!(
    contact_type: contact_type,
    value: value
  )

end

puts "Seed finalizado com sucesso! 🎉"
