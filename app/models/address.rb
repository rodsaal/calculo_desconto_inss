class Address < ApplicationRecord
  belongs_to :proponent

  validates :street, :number, :city, :state, :zip_code, presence: true
end
