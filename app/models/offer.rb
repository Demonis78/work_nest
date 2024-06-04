class Offer < ApplicationRecord
  belongs_to :venue

  has_many :orders

  has_many :variants, dependent: :destroy

  validates :title, :description, :price, presence: true
end

