class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_subscriber, :remove_subscriber]
  before_action :check_project_ownership, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
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
    if user_is_already_subscribed?
      redirect_to @project, flash: { error: "You are already subscribed to this project."  }
    else
      @project.subscribers << current_user
      redirect_to @project, notice: "You was successfully subscribed to this project."
    end
  end

  def remove_subscriber
    if user_is_already_subscribed?
      @project.subscribers.destroy(current_user)
      redirect_to @project, notice: "You was successfully removed from the subscribed list."
    else
      redirect_to @project, flash: { error: "You are not subscribed to this project." }
    end
  end

  private
    def user_is_already_subscribed?
      @project.subscribers.include?(current_user)
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def check_project_ownership
      return if @project.owner == current_user
      flash[:error] = "Project doesn't belongs to you."
      redirect_to projects_url
    end

    def project_params
      params.require(:project).permit(:title, :description)
    end
end
