class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  before_action :check_project_ownership, only: [:edit, :update, :destroy]
  before_action :validate_admin_user, only: [:admin_force_remove_subscriber]

  def index
    @projects = Project.left_outer_joins(:subscribers).group("projects.id").select("projects.*, count(users.id) as users_count").order("users_count ASC").order("projects.id DESC").uniq
  end

  def show
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
      redirect_to @project, notice: "You was successfully subscribed to this project."
    end
  end

  def remove_subscriber
    if user_is_already_subscribed?(current_user)
      @project.subscribers.destroy(current_user)
      redirect_to @project, notice: "You was successfully removed from the subscribed list."
    else
      redirect_to @project, flash: { error: "You are not subscribed to this project." }
    end
  end

  def admin_force_remove_subscriber
    user = User.find(params[:user_id])
    @project.subscribers.destroy(user)
    redirect_to @project, notice: "#{user.name} was removed from the subscribed list."
  end

  private
    def validate_admin_user
      return if current_user.is_admin
      flash[:error] = "You are not an admin."
      redirect_to root_url
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
