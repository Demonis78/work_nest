class Admin::HomeController < Admin::AdminController
  def index
    @offers = Offer.all
  end
end
