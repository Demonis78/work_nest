class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.decimal :price, preciosion: 10, scale: 2
      t.references :venue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
