class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_id
  end

  helper_method :current_user
  
end
