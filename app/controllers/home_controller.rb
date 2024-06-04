class HomeController < ApplicationController
  def index
    @offers = Offer.all
  end
end
