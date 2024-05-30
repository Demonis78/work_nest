class AddCompanyNameToVenueAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :venue_admins, :company_name, :string
  end
end
