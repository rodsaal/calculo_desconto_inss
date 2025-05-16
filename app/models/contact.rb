class Contact < ApplicationRecord
  belongs_to :proponent

  validates :contact_type, :value, presence: true
end
