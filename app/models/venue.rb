class Venue < ApplicationRecord
  has_many :offers, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_many :reservations, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :name, :description, presence: true
end


