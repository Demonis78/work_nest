class Admin::ReservationsController < Admin::AdminController
  before_action :authenticate_venue_admin!
  before_action :set_venue, only: [:new, :create, :index, :destroy]

  def index
    @reservations = @venue.reservations.order(start_date: :asc)
  end

  def new
    @reservation = @venue.reservations.build
    @offer = Offer.find_by(id: params[:offer_id])
    @variant = @offer.present? ? @offer.variants.find_by(id: params[:variant_id]) : nil

    if @offer.nil?
      redirect_to admin_venue_reservations_path(@venue), alert: 'Offer not found.'
      return
    end

    @unavailable_dates = @venue.reservations
                          .where(offer: @offer)
                          .pluck(:start_date, :end_date)

    @reservation.offer = @offer
    @reservation.variants << @variant if @variant

    @offers = @venue.offers
  end

  def create
    @reservation = @venue.reservations.build(reservation_params)
    @reservation.venue_admin = current_venue_admin

    if @reservation.start_date.present? && @reservation.end_date.blank?
      @reservation.end_date = @reservation.start_date + 1.month
    end

    if @reservation.save
      redirect_to admin_venue_reservations_path(@venue), notice: 'Reservation was successfully created.'
    else
      @offer = Offer.find_by(id: reservation_params[:offer_id])
      render :new
    end
  end

  def destroy
    @reservation = current_venue_admin.reservations.find(params[:id])
    @reservation.destroy
    redirect_to admin_venue_reservations_path(@venue), notice: 'Reservation was successfully canceled.'
  end

  private

  def set_venue
    @venue = current_venue_admin.venues.find(params[:venue_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :offer_id, variant_ids: [])
  end
end
