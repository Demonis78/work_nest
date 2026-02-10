class Admin::CompaniesController < Admin::AdminController
  before_action :authenticate_venue_admin!
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
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('new_company', partial: 'companies/form',
                                                                   locals: { company: @company })
        end
      end
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, address_attributes: %i[street city country])
  end
end
