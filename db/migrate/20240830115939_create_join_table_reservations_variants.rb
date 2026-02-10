class CreateJoinTableReservationsVariants < ActiveRecord::Migration[7.1]
  def change
    create_join_table :reservations, :variants do |t|
      t.index :reservation_id
      t.index :variant_id
      t.index %i[reservation_id variant_id], unique: true
    end
  end
end
