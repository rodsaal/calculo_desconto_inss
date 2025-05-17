require 'rails_helper'

RSpec.describe "INSS calculation", type: :request do
  describe "GET /inss_discount" do
    it "returns correct discount for first bracket" do
      get inss_discount_path, params: { salary: 1045.00 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(78.38)
    end

    it "returns correct discount for second bracket" do
      get inss_discount_path, params: { salary: 2089.60 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(172.39)
    end

    it "returns correct discount for third bracket" do
      get inss_discount_path, params: { salary: 3134.40 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(297.77)
    end

    it "returns correct discount for fourth bracket (above third)" do
      get inss_discount_path, params: { salary: 6101.06 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(713.10)
    end

    it "returns correct discount for example salary R$ 3000.00" do
      get inss_discount_path, params: { salary: 3000 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(281.64)
    end

    it "returns 0.0 for zero salary" do
      get inss_discount_path, params: { salary: 0 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(0.0)
    end

    it "returns 0.0 for negative salary" do
      get inss_discount_path, params: { salary: -1000 }
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(0.0)
    end

    it "returns 0.0 when salary param is missing" do
      get inss_discount_path
      json = JSON.parse(response.body)
      expect(json["discount"]).to eq(0.0)
    end
  end
end
