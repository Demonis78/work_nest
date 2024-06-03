class Venue < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :offers, dependent: :destroy

  validates :name, :description, presence: true
end
