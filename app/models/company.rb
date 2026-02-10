class Company < ApplicationRecord
  has_many :venue_admins
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :name, presence: true
end
