class AddPeriodToVariants < ActiveRecord::Migration[7.1]
  def change
    add_column :variants, :period, :string
  end
end
