class OffersController < ApplicationController
  before_action :set_venue, only: [:new, :create]

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
      redirect_to [@venue, @offer], notice: 'Offer was successfully created.'
    else
      render :new
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id]) if params[:venue_id]
  end

  def offer_params
    params.require(:offer).permit(:title, :description, :price)
  end
end
