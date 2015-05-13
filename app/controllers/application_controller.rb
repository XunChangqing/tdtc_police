class ApplicationController < ActionController::Base
  def current_user
    User.find_by_username(session[:cas_user])
  end
  helper_method :current_user


  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_url, :alert => exception.message
    redirect_to root_url, :alert => t("common.not_allowed_access")
  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
