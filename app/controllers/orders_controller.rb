class OrdersController < ApplicationController
  before_action :authenticate_venue_admin!
  before_action :set_offer, expect: [:new, :create]

  def new
    @order = Order.new
  end

  def create
    @order = @offer.orders.build(order_params)
    if @order.save
      redirect_to offer_path(@offer), notice: 'Order was successfully created.'
    else
      render 'offers/show', status: :unprocessable_entity
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def order_params
    params.require(:order).permit(:duration)
  end
end