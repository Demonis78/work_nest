class UpdateExistingOrdersWithVariantId < ActiveRecord::Migration[6.1]
  def up
    Order.find_each do |order|
      variant = Variant.find_by(offer_id: order.offer_id)
      if variant
        order.update_column(:variant_id, variant.id) 
      else
        order.destroy 
      end
    end
  end

  def down
  end
end
