class OrdersController < ApplicationController
  before_action :authenticate_venue_admin!
  before_action :set_offer, only: [:new, :create]

  def new
    @order = @offer.orders.build
  end

  def create
    @order = @offer.orders.build(order_params)
    if @order.save
      respond_to do |format|
        format.html { redirect_to offer_path(@offer), notice: 'Order was successfully created.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render 'offers/show', status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_order", partial: "orders/form", locals: { offer: @offer, order: @order }) }
      end
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def order_params
    params.require(:order).permit(:quantity)
  end
end
