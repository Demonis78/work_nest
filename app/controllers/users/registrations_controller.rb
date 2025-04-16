module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def create
      super 
    end

    protected
  
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up)
    end
  end
end
  
