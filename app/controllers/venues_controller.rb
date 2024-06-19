class VenuesController < ApplicationController
  before_action :set_venue, only: [:edit, :update, :destroy]

  def index
    @venues = Venue.all.sort_by(&:name)
  end

  def show
    @venue = Venue.find(params[:id])
    @offers = @venue.offers.includes(:variants)
  end
  
  def new
    @venue = Venue.new
    @venue.build_address
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      respond_to do |format|
        format.html {redirect_to @venue, notice: 'Venue was successfully created.'}
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @venue.update(venue_params)
      respond_to do |format|
        format.html { redirect_to venues_path, notice: 'Venue was successfully updated.' }
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_path, notice: 'Venue was successfully deleted.' }
      format.turbo_stream
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to venues_path, alert: 'Venue not found.'
  end

  def venue_params
    params.require(:venue).permit(:name, :description, address_attributes: [:street, :city, :country])
  end
end
