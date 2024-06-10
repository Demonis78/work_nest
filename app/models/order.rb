class Order < ApplicationRecord
  belongs_to :variant
  belongs_to :offer

  validates :period, presence: true

  def total_price
    variant.price
  end
end
