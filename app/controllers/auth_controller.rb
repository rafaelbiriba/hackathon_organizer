class AuthController < ApplicationController
  skip_before_action :validate_user_logged
  skip_before_action :define_notifications_counter

  def callback
    data = request.env["omniauth.auth"].info
    user = update_or_create_user(data)
    create_user_session(user)

    redirect_to projects_url
  end

  def failure
    render plain: params[:message]
  end

  def login
  end

  def logout
    session[:current_user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to auth_login_url
  end

  private

  def update_or_create_user(data)
    User.find_or_initialize_by(email: data.email).tap do |user|
      user.name = data.name
      user.profile_image_url = data.image
      user.save!
    end
  end

  def create_user_session(user)
    session[:current_user_id] = user.id
  end
end
