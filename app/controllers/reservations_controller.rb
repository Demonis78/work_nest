class ReservationsController < ApplicationController
  before_action :authenticate_venue_admin!
  before_action :set_venue, only: [:new, :create]

  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = @venue.reservations.build
    @offers = @venue.offers
  end

  def create
    @reservation = @venue.reservations.build(reservation_params)
    @reservation.venue_admin = current_venue_admin

    if @reservation.save
      redirect_to venue_reservations_path(@venue), notice: 'Reservation was successfully created.'
    else
      @offers = @venue.offers
      render :new
    end
  end

  def destroy
    @reservation = current_venue_admin.reservations.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: 'Reservation was successfully canceled.'
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def reservation_params
    params.require(:reservation).permit(:offer_id, :start_date, :end_date)
  end
end
