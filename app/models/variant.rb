# app/models/variant.rb
class Variant < ApplicationRecord
  belongs_to :offer
  validates :name, :price, :period, presence: true

  def self.options_for_desk
    [
      { name: "Per Day", price: 10.00, period: "day" },
      { name: "Per Month", price: 75.00, period: "month" }
    ]
  end

  def self.options_for_desk_with_extra_screen
    [
      { name: "Per Day", price: 15.00, period: "day" },
      { name: "Per Month", price: 100.00, period: "month" }
    ]
  end
end
