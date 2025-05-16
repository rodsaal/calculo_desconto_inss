require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'associations' do
    it { should belong_to(:proponent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:contact_type) }
    it { should validate_presence_of(:value) }
  end
end
