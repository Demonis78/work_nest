class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :venue, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.references :venue_admin, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
