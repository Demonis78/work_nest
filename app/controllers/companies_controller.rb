class CompaniesController < ApplicationController
  def new
    @company = Company.new
    @company.build_address
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Company was successfully created.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_company", partial: "companies/form", locals: { company: @company }) }
      end
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, address_attributes: [:street, :city, :state, :country])
  end
end
