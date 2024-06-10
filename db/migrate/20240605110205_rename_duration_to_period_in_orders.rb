class RenameDurationToPeriodInOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :duration, :period
  end
end
