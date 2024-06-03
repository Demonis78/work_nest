class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
    @venue.build_address
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to venues_path, notice: 'Venue was successfully created.'
    else
      render :new
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :description, address_attributes: [:street, :city, :state, :country])
  end
end
