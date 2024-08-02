class RemoveBasePriceFromOffers < ActiveRecord::Migration[7.1]
  def change
    remove_column :offers, :base_price, :decimal
  end
end
