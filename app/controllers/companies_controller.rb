class CompaniesController < ApplicationController
  def new
    @company = Company.new
    @company.build_address
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to root_path, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, address_attributes: [:street, :city, :state, :country])
  end
end
