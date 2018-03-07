class UsersController < ApplicationController
  before_action :validate_admin_user
  before_action :find_user, except: [:index]
  before_action :check_for_superuser, only: [:revoke_user_admin]

  def index
    @users = User.all.order(:name)
  end

  def give_user_admin
    @user.is_admin = true
    @user.save!
    redirect_to users_url, notice: "#{@user.name} is now an admin."
  end

  def revoke_user_admin
    @user.is_admin = false
    @user.save!
    redirect_to users_url, notice: "#{@user.name} is no longer an admin."
  end

  private
  def find_user
    @user ||= User.find(params[:id])
  end

  def check_for_superuser
    return unless @user.is_superuser
    flash[:error] = "You can not remove this admin user."
    redirect_to root_url
  end

  def validate_admin_user
    return if current_user.is_admin
    flash[:error] = "You are not an admin."
    redirect_to root_url
  end
end
