class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticated?
  helper_method :current_user

  private

  def current_user
    return if session[:user_id].blank?
    @current_user ||= User.find(session[:user_id])
  end

  def authenticated?
    redirect_to new_session_path unless current_user
  end
end
