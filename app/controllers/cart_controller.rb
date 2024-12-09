class CartController < ApplicationController
  def index
    variant_ids = session[:selected_variants] || []
    @selected_variants = Variant.where(id: variant_ids)
    
    @variant_count = @selected_variants.size
  end
  
  def select_variant
    @variant = @offer.variants.find(params[:variant_id])
    
    session[:selected_variants] ||= []
    session[:selected_variants] |= [@variant.id]
  end
  
  def remove_variant
    session[:selected_variants].delete(params[:variant_id].to_i)
    redirect_to cart_index_path
  end
end