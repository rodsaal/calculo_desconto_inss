require 'rails_helper'

RSpec.describe Proponent, type: :model do
  it { should have_many(:addresses).dependent(:destroy) }
  it { should have_many(:contacts).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:document) }
  it { should validate_presence_of(:birthdate) }
  it { should validate_presence_of(:salary) }

  it { should validate_numericality_of(:salary).is_greater_than(0) }
  it { should validate_uniqueness_of(:document) }
end
