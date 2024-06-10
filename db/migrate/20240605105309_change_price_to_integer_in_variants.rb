class ChangePriceToIntegerInVariants < ActiveRecord::Migration[7.1]
  def change
    change_column :variants, :price, :integer
  end
end
