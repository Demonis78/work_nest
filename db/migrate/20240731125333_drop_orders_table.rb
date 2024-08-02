class DropOrdersTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :orders
  end

  def down
    create_table :orders do |t|
      t.string :period
      t.references :offer, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
