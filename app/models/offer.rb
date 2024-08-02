# app/models/offer.rb
class Offer < ApplicationRecord
  belongs_to :venue
  has_many :variants, dependent: :destroy
  has_many :reservations, dependent: :destroy
  
  accepts_nested_attributes_for :variants, allow_destroy: true
  validates :title, :description, presence: true

  def total_price(selected_variant_ids)
    variants.where(id: selected_variant_ids).sum(:price)
  end
end
