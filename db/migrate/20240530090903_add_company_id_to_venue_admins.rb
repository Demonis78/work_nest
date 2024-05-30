class AddCompanyIdToVenueAdmins < ActiveRecord::Migration[7.1]
  def change
    add_reference :venue_admins, :company, null: false, foreign_key: true
  end
end
