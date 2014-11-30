class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  def set_current_user
    if logininfo_signed_in?
      @current_user = current_logininfo.user
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_id
  end

  helper_method :current_user
  
end
