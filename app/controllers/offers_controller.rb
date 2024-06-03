class OffersController < ApplicationController
  def index
    @venues = Venue.includes(:offers).all
  end

  def show
    @offer = Offer.find(params[:id])
  end
  
  def new
    @venue = Venue.find(params[:venue_id])
    @offer = @venue.offers.build
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @offer = @venue.offers.build(offer_params)
    if @offer.save
      redirect_to root_path, notice: 'Offer was successfully created.'
    else
      render :new
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :description, :price)
  end
end
