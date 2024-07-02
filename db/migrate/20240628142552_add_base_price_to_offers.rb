class AddBasePriceToOffers < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :base_price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
