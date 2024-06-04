class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :duration
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
