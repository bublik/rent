class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  before_filter :autologin
  private
  def autologin
    if !user_signed_in? && params[:token]
      user = User.find_by_auth_token(params[:token])
      sign_in user
    end
  end
  #
  #def log_action
  #  logger.debug(action_name.inspect)
  #end
end
