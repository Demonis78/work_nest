# app/models/offer.rb
class Offer < ApplicationRecord
  belongs_to :venue
  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true
  validates :title, :description, :base_price, presence: true

  def total_price(selected_variant_ids)
    base_price + variants.where(id: selected_variant_ids).sum(:price)
  end
end
