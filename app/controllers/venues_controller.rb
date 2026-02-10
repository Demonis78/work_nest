class VenuesController < ApplicationController
  before_action :cache_location, only: [:search]

  def index
    @venues = Venue.includes(:address).order(:name)
  end

  def search
    @location = cached_location
    @venues = Venue.joins(:address).where('addresses.city like ?', "%#{cached_location}%")
  end

  def show
    @venue = Venue.find(params[:id])
  end

  private

  def cache_location
    return if params[:location].blank?

    session[:location] = params[:location]
  end

  def cached_location
    session[:location]
  end
end
