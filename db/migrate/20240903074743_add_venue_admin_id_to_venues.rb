class AddVenueAdminIdToVenues < ActiveRecord::Migration[7.1]
  def change
    add_reference :venues, :venue_admin, foreign_key: true
  end
end
