class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  before_action :check_project_ownership, only: [:edit, :update, :destroy]
  before_action :validate_admin_user, only: [:admin_force_remove_subscriber]

  def index
    @projects = load_projects_based_on_order
    @total_count = @projects.uniq.count
    apply_filters!
    apply_search!
    @projects = @projects.uniq
  end

  def show
    @comment = Comment.new
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.owner = current_user

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: "Project was successfully destroyed."
  end

  def add_subscriber
    if user_is_already_subscribed?(current_user)
      redirect_to @project, flash: { error: "You are already subscribed to this project."  }
    else
      @project.subscribers << current_user
      send_notifications(Notifications::UserSubscribed)
      redirect_to @project, notice: "You was successfully subscribed to this project."
    end
  end

  def remove_subscriber
    if user_is_already_subscribed?(current_user)
      @project.subscribers.destroy(current_user)
      send_notifications(Notifications::UserUnsubscribed)
      redirect_to @project, notice: "You was successfully removed from the subscribed list."
    else
      redirect_to @project, flash: { error: "You are not subscribed to this project." }
    end
  end

  def admin_force_remove_subscriber
    user = User.find(params[:user_id])
    @project.subscribers.destroy(user)
    send_notifications(Notifications::UserUnsubscribedByAdmin)
    redirect_to @project, notice: "#{user.name} was removed from the subscribed list."
  end

  def add_thumbs_up
    if user_already_gave_thumbs_up?
      redirect_to @project, flash: { error: "You already gave the thumbs up for this project." }
    else
      @project.thumbs_up.create!(creator: current_user)
      send_notifications(Notifications::NewThumbsUp)
      redirect_to @project, notice: "Your thumbs up was successfully saved."
    end
  end


  def remove_thumbs_up
    if user_already_gave_thumbs_up?
      @project.thumbs_up.where(creator: current_user).destroy_all
      send_notifications(Notifications::RemovedThumbsUp)
      redirect_to @project, notice: "Your thumbs up was successfully removed."
    else
      redirect_to @project, flash: { error: "You did not gave the thumbs up for this project." }
    end
  end

  private

  def apply_filters!
    if params["filter"] == "created_by_me"
      @projects = @projects.where(owner_id: current_user.id)
    elsif params["filter"] == "subscribed"
      @projects = @projects.left_outer_joins(:subscribers).where("users.id = ?", current_user.id)
    elsif params["filter"] == "liked"
      @projects = @projects.left_outer_joins(:thumbs_up).where("creator_id = ?", current_user.id)
    elsif params["filter"] == "commenting"
      @projects = @projects.left_outer_joins(:comments).where("comments.owner_id = ?", current_user.id)
    end
  end

  def apply_search!
    return unless params[:search]
    @projects = @projects.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end

  def load_projects_based_on_order
    project = Project.group("projects.id")
    if params["order"] == "top_likes"
      project.left_outer_joins(:thumbs_up).select("projects.*, count(thumbs_up.id) as thumbs_up_count").order("thumbs_up_count DESC").order("projects.id DESC")
    elsif params["order"] == "top_comments"
      project.left_outer_joins(:comments).select("projects.*, count(comments.id) as comments_count").order("comments_count DESC").order("projects.id DESC")
    elsif params["order"] == "top_subscribers"
      project.left_outer_joins(:subscribers).select("projects.*, count(users.id) as users_count").order("users_count DESC").order("projects.id ASC")
    else
      project.left_outer_joins(:subscribers).select("projects.*, count(users.id) as users_count").order("users_count ASC").order("projects.id DESC")
    end
  end

  def send_notifications(notification_klass)
    @project.all_involved_users(except_user: current_user).each do |user|
      notification_klass.create!(user_related: current_user, user_target: user, project: @project)
    end
  end

  def validate_admin_user
    return if current_user.is_admin
    flash[:error] = "You are not an admin."
    redirect_to root_url
  end

  def user_already_gave_thumbs_up?
    @project.thumbs_up.where(creator: current_user).exists?
  end

  def user_is_already_subscribed?(user)
    @project.subscribers.include?(user)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def check_project_ownership
    return if @project.owner == current_user || current_user.is_admin
    flash[:error] = "Project doesn't belongs to you."
    redirect_to projects_url
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
