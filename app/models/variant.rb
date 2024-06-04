class Variant < ApplicationRecord
  belongs_to :offer

  validates :name, :price, presence: true
end

