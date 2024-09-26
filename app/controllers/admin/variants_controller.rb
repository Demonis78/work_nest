class Admin::VariantsController < Admin::AdminController
  before_action :set_offer, only: [:new, :create, :edit, :update, :show]
  before_action :set_variant, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_venue_admin!

  def new
    @variant = @offer.variants.build
  end

  def show
  end

  def edit
  end

  def create
    @variant = @offer.variants.build(variant_params)
    if @variant.save
      respond_to do |format|
        format.html do 
          flash[:notice] = "Variant was successfully created."
          redirect_to admin_offer_path(@offer)
        end
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def update
    if @variant.update(variant_params)
      respond_to do |format|
        format.html do 
          flash[:notice] = "Variant was successfully updated."
          redirect_to admin_offer_path(@offer)
        end
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    if @variant
      @variant.destroy
      respond_to do |format|
        format.html { redirect_to @variant.offer, notice: 'Variant was successfully deleted.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Variant not found.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("notice-container", partial: "shared/flash", locals: { flash: { alert: 'Variant not found.' } }) }
      end
    end
  end
  
  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:price, :period, :offer_id)
  end
end
