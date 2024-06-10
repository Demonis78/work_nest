class RemovePriceFromOffers < ActiveRecord::Migration[7.1]
  def change
    remove_column :offers, :price, :decimal
  end
end
