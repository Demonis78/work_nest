class VenuesController < ApplicationController
  before_action :cache_location, only: [:search]

  CITY_GROUPS = [
    ["kraków", "krakow", "cracow"],
    ["warszawa", "warsaw"],
    ["katowice"]
  ].freeze

  def index
    @venues = Venue.includes(:address).order(:name)
  end

  def search
    @location = params[:q].to_s.strip
    variants = city_variants_for_query(@location)

    @venues = if variants.empty?
                Venue.none
              else
                Venue.joins(:address)
                     .includes(:offers)
                     .where("LOWER(addresses.city) IN (?)", variants)
                     .order(:name)
              end
  end

  def show
    @venue = Venue.find(params[:id])
  end

  private

  def city_variants_for_query(value)
    norm = I18n.transliterate(value.to_s).downcase.strip
    return [] if norm.blank?

    CITY_GROUPS.each do |group|
      return group if group.any? { |syn| syn.downcase == norm }
    end

    [norm]
  end

  def cache_location
    return if params[:location].blank?

    session[:location] = params[:location]
  end

  def cached_location
    session[:location]
  end
end
