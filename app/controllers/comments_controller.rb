class CommentsController < ApplicationController
  before_action :load_edition
  before_action :set_project

  def create
    @comment = Comment.new(comment_params)

    if @comment.update(project: @project, owner: current_user)
      redirect_to edition_project_path(@edition, @project, anchor: "comment-#{@comment.id}"), notice: "Your comment was successfully created."
    else
      flash[:error] = "Something is wrong!"
      render "projects/show"
    end
  end

  private

  def load_edition
    @edition ||= Edition.find(params[:edition_id])
  end

  def set_project
    @project = @edition.projects.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
