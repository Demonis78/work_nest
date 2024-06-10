class AddVariantIdToOrdersWithoutNullConstraint < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :variant, foreign_key: true
  end
end
