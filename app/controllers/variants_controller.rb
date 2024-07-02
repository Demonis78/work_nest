class VariantsController < ApplicationController
  before_action :set_offer, only: [:new, :create]
  before_action :set_variant, only: [:destroy]
  before_action :authenticate_venue_admin!

  def new
    @variant = @offer.variants.build
  end

  def create
    @variant = @offer.variants.build(variant_params)
    if @variant.save
      respond_to do |format|
        format.html { redirect_to @offer, notice: 'Variant was successfully created.' }
        format.turbo_stream
      end
    else
      render :new
    end
  end 

  def destroy
    if @variant
      @variant.destroy
      respond_to do |format|
        format.html { redirect_to @variant.offer, notice: 'Variant was successfully deleted.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Variant not found.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("notice-container", partial: "shared/flash", locals: { flash: { alert: 'Variant not found.' } }) }
      end
    end
  end
  
  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:name, :price, :period)
  end
end
