require 'rails_helper'

RSpec.describe "Proponents", type: :request do
  describe "POST /proponents" do
    let(:valid_params) do
      {
        proponent: {
          name: "Maria Silva",
          document: "12345678900",
          birthdate: "1990-01-01",
          salary: 3000.00,
          addresses_attributes: [{
            street: "Flower Street",
            number: "123",
            neighborhood: "Downtown",
            city: "São Paulo",
            state: "SP",
            zip_code: "01000-000"
          }],
          contacts_attributes: [{
            contact_type: "email",
            value: "maria@example.com"
          }]
        }
      }
    end

    let(:invalid_params) do
      {
        proponent: {
          name: "",
          document: "",
          birthdate: "",
          salary: nil
        }
      }
    end

    it "creates a new proponent with valid data" do
      expect {
        post proponents_path, params: valid_params
      }.to change(Proponent, :count).by(1)
    
      expect(response).to redirect_to(Proponent.last)
      follow_redirect!
    
      expect(response.body).to include("Proponent created")
      expect(response.body).to include("Maria Silva")
      expect(response.body).to include("R$ 3.000,00").or include("$3,000.00")
    end
    

    it "does not create a proponent with invalid data" do
      expect {
        post proponents_path, params: invalid_params
      }.not_to change(Proponent, :count)

      expect(response.body).to include("proponent")
    end
  end
end
