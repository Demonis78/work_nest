class VariantsController < ApplicationController
  def new
    @offer = Offer.find(params[:offer_id])
    @variant = @offer.variants.build
  end

  def create
    @offer = Offer.find(params[:offer_id])
    @variant = @offer.variants.build(variant_params)
    if @variant.save
      redirect_to root_path, notice: 'Variant was successfully created.'
    else
      render :new
    end
  end

  private

  def variant_params
    params.require(:variant).permit(:name, :price)
  end
end
