class Proponent < ApplicationRecord
    has_many :addresses, dependent: :destroy
    has_many :contacts, dependent: :destroy
  
    accepts_nested_attributes_for :addresses, allow_destroy: true
    accepts_nested_attributes_for :contacts, allow_destroy: true
  
    validates :name, :document, :birthdate, :salary, presence: true
    validates :salary, numericality: { greater_than: 0 }
    validates :document, uniqueness: true
  end
  