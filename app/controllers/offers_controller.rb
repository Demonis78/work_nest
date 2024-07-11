class OffersController < ApplicationController
  before_action :authenticate_venue_admin!
  before_action :set_venue, only: [:new, :create]
  before_action :set_offer, only: [:show, :destroy, :select_variant]
  
  def index
    if params[:venue_id]
      @venue = Venue.find_by(id: params[:venue_id])
      @offers = @venue ? @venue.offers : []
    else
      @offers = Offer.all
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @variants ||= @offer.variants.order(price: :desc) if @offer
  end

  def new
    @offer = @venue.offers.build
  end

  
  def create
    @offer = @venue.offers.build(offer_params)
    if @offer.save
      respond_to do |format|
        format.html { redirect_to venue_path(@venue), notice: 'Offer was successfully created.' }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @offer.update(offer_params)
      redirect_to @offer, notice: 'Offer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @offer.destroy
      respond_to do |format|
        format.html { redirect_to venue_path(@offer.venue), notice: 'Offer was successfully deleted.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to venue_path(@offer.venue), alert: 'Failed to delete offer.' }
        format.turbo_stream
      end
    end
  end
  def select_variant
    @variant = @offer.variants.find(params[:variant_id])
    
    session[:selected_variants] ||= []
    session[:selected_variants] << @variant.id
    
    redirect_to offer_path(@offer), notice: 'Variant selected successfully'
  end

  private
  def set_venue
    @venue = Venue.find(params[:venue_id])
  end
  def set_offer
    @offer = Offer.find(params[:id])
  end
  def offer_params
    params.require(:offer).permit(:title, :description, :base_price)
  end
end
