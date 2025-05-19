require 'rails_helper'

RSpec.describe "Proponents", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "123456") }

  before do
    sign_in user
  end
  
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
    
      expect(response.body).to include("Proponente criado com sucesso.")
      expect(response.body).to include("Maria Silva")
      expect(response.body).to include("3.000").or include("3,000").or include("3000")
    end
    

    it "does not create a proponent with invalid data" do
      expect {
        post proponents_path, params: invalid_params
      }.not_to change(Proponent, :count)

      expect(response.body).to include("proponent")
    end

    it "creates a proponent with multiple addresses and contacts" do
      params = {
        proponent: {
          name: "João da Silva",
          document: "98765432100",
          birthdate: "1985-03-01",
          salary: 4500.00,
          addresses_attributes: [
            {
              street: "Rua A", number: "10", neighborhood: "Bairro A",
              city: "Cidade A", state: "SP", zip_code: "01000-000"
            },
            {
              street: "Rua B", number: "20", neighborhood: "Bairro B",
              city: "Cidade B", state: "RJ", zip_code: "20000-000"
            }
          ],
          contacts_attributes: [
            { contact_type: "celular", value: "99999-9999" },
            { contact_type: "email", value: "joao@example.com" }
          ]
        }
      }

      expect {
        post proponents_path, params: params
      }.to change(Proponent, :count).by(1)
      .and change(Address, :count).by(2)
      .and change(Contact, :count).by(2)

      proponent = Proponent.last
      expect(proponent.addresses.map(&:city)).to include("Cidade A", "Cidade B")
      expect(proponent.contacts.map(&:contact_type)).to include("celular", "email")
    end
  end

  describe "DELETE /proponents/:id" do
    it "removes the proponent and redirects to dashboard" do
      proponent = Proponent.create!(
        name: "Carlos Souza",
        document: "11223344556",
        birthdate: "1980-02-02",
        salary: 2500.00,
        addresses_attributes: [{
          street: "Rua Central",
          number: "123",
          neighborhood: "Centro",
          city: "Rio de Janeiro",
          state: "RJ",
          zip_code: "20000-000"
        }],
        contacts_attributes: [{
          contact_type: "email",
          value: "carlos@example.com"
        }]
      )

      expect {
        delete proponent_path(proponent)
      }.to change(Proponent, :count).by(-1)

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Proponente removido com sucesso")
    end
  end

  describe "PATCH /proponents/:id" do
    let!(:proponent) do
      Proponent.create!(
        name: "Antigo Nome",
        document: "99999999999",
        birthdate: "1980-01-01",
        salary: 2000.00,
        addresses_attributes: [{
          street: "Rua Antiga",
          number: "1",
          neighborhood: "Centro",
          city: "Cidade",
          state: "SP",
          zip_code: "00000-000"
        }],
        contacts_attributes: [{
          contact_type: "email",
          value: "antigo@example.com"
        }]
      )
    end

    it "updates a proponent with valid data" do
      patch proponent_path(proponent), params: {
        proponent: {
          name: "Novo Nome",
          salary: 3000.00
        }
      }

      expect(response).to redirect_to(proponent)
      follow_redirect!

      expect(response.body).to include("Novo Nome")
      expect(response.body).to include("R$ 3.000,00").or include("$3,000.00")
    end

    it "does not update a proponent with invalid data" do
      patch proponent_path(proponent), params: {
        proponent: {
          name: "",
          salary: nil
        }
      }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Proponente")
    end
  end
end
