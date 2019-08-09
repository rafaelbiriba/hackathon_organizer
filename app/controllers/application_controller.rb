class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user if Rails.env.development?
  before_action :validate_user_logged
  before_action :define_notifications_counter

  private
  def validate_user_logged
    return if current_user
    flash[:error] = "You are not logged."
    redirect_to auth_login_url
  end

  def define_notifications_counter
    @new_notifications_count = current_user.notifications.not_visualized.count
  end

  def current_user
    user_id = session[:current_user_id]
    @current_user ||= user_id && User.find_by(id: user_id)
  end

  # development only
  def set_current_user
    session[:current_user_id] = params[:user] if params[:user]
  end

  def validate_admin_user
    return if current_user.is_admin
    flash[:error] = "You are not an admin."
    redirect_to root_url
  end
end
