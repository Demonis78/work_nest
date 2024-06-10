class Offer < ApplicationRecord
  belongs_to :venue
  has_many :orders
  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true
  validates :title, :description, presence: true
end

