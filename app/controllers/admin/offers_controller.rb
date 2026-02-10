class Admin::OffersController < Admin::AdminController
  before_action :authenticate_venue_admin!
  before_action :set_venue, only: %i[new create edit update]
  before_action :set_offer, only: %i[show edit destroy update select_variant remove_variant]

  def index
    if params[:venue_id]
      @venue = Venue.find(params[:venue_id])
      @offers = @venue ? @venue.offers : []
    else
      @offers = Offer.all
      @venue = nil
    end
  end

  def show
    @variants ||= @offer.variants.order(price: :desc)
    @venue = @offer.venue
  end

  def new
    if @venue.nil?
      redirect_to admin_offers_path, alert: 'Venue not found.'
    else
      @offer = @venue.offers.build
    end
  end

  def create
    if @venue.nil?
      redirect_to admin_offers_path, alert: 'Venue not found.'
    else
      @offer = @venue.offers.build(offer_params)
      if @offer.save
        respond_to do |format|
          format.html { redirect_to admin_venue_path(@venue), notice: 'Offer was successfully created.' }
          format.turbo_stream
        end
      else
        render :new
      end
    end
  end

  def edit; end

  def update
    if @offer.update(offer_params)
      redirect_to admin_offer_path(@offer), notice: 'Offer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @offer.destroy
      respond_to do |format|
        format.html { redirect_to admin_venue_path(@offer.venue), notice: 'Offer was successfully deleted.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_venue_path(@offer.venue), alert: 'Failed to delete offer.' }
        format.turbo_stream
      end
    end
  end

  def select_variant
    @variant = @offer.variants.find(params[:variant_id])

    session[:selected_variants] ||= []
    session[:selected_variants] |= [@variant.id]
  end

  def remove_variant
    session[:selected_variants].delete(params[:variant_id].to_i)
    redirect_to selected_variants_admin_offers_path, notice: 'Variant removed successfully'
  end

  def selected_variants
    @selected_variants = Variant.where(id: session[:selected_variants] || [])
    @total_price = @selected_variants.sum(&:price)
    @venue_id = @selected_variants.first&.offer&.venue_id

    return unless @venue_id.nil?

    redirect_to admin_offers_path, alert: 'No variants selected or unable to determine venue.'
  end

  private

  def set_venue
    @venue = Venue.find_by(id: params[:venue_id]) if params[:venue_id]
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :description, :venue_id,
                                  variant_attributes: %i[id price_type price _destroy])
  end
end
