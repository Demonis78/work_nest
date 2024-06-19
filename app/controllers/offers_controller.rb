class OffersController < ApplicationController
  before_action :authenticate_venue_admin!
  before_action :set_venue, only: [:new, :create]
  before_action :set_offer, only: [:show, :destroy]
  
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

  def destroy
    puts "Destroy action called"
    puts "Offer: #{@offer.inspect}"
    
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

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
    puts "Venue: #{@venue.inspect}"
  end

  def set_offer
    @offer = Offer.find(params[:id])
    puts "Offer set: #{@offer.inspect}"
  end

  def offer_params
    params.require(:offer).permit(:title, :description)
  end
end
