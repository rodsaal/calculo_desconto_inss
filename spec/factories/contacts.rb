FactoryBot.define do
  factory :contact do
    association :proponent
    contact_type { %w[residencial celular whatsapp email].sample }

    value do
      case contact_type
      when "residencial", "celular", "whatsapp"
        Faker::PhoneNumber.cell_phone_in_e164
      when "email"
        Faker::Internet.email
      else
        "Contato Genérico"
      end
    end
  end
end