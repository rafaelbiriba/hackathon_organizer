class CommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = Comment.new(comment_params)

    if @comment.update(project: @project, owner: current_user)
      redirect_to project_path(@project, anchor: "comment-#{@comment.id}"), notice: "Your comment was successfully created."
    else
      flash[:error] = "Something is wrong!"
      render "projects/show"
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
