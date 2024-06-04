class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:company_name])
  end

  def after_sign_in_path_for(resource)
    offers_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
