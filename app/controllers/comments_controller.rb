class CommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = Comment.new(comment_params)
    @comment.project = @project
    @comment.owner = current_user

    if @comment.save
      redirect_to project_path(@project, anchor: "comment-#{@comment.id}"), notice: 'Your comment was successfully created.'
    else
      render "projects/show"
    end
  end

  private
    def set_comment
      @comment = @project.comments.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
