class NotificationsController < ApplicationController

  before_action :clean_old_notifications
  after_action :mark_all_as_visualized, except: [:counter]

  def index
  end

  def destroy_all
    @notifications.destroy_all
    redirect_to notifications_url, notice: "All notifications was successfully removed."
  end

  def counter
    render json: { notifications_count: @new_notifications_count }
  end

  private
  def clean_old_notifications
    notifications.old_visualized_notifications.destroy_all
  end

  def mark_all_as_visualized
    notifications.update_all(visualized: true)
  end

  def notifications
    @notifications ||= current_user.notifications.order("id DESC")
  end
end
