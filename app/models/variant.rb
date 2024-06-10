class Variant < ApplicationRecord
  belongs_to :offer
  has_many :orders, dependent: :destroy
  validates :name, :price, :period, presence: true
end

