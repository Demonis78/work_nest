# app/models/variant.rb
class Variant < ApplicationRecord
  belongs_to :offer
  has_and_belongs_to_many :reservations
  validates :price, presence: true
  validates :period, uniqueness: { scope: :offer_id, message: "already exists for this offer. You can only have one price for a given period." }
end
