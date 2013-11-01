class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:full_name, :email, :password, :password_confirmation,
        company_attributes: [:name])
    end
  end

  def current_company
    @current_company ||= current_user.company
  end
  helper_method :current_company
end
