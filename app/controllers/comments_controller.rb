class CommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = Comment.new(comment_params)
    @comment.project = @project
    @comment.owner = current_user

    if @comment.save
      send_notifications
      redirect_to project_path(@project, anchor: "comment-#{@comment.id}"), notice: 'Your comment was successfully created.'
    else
      render "projects/show"
    end
  end

  private

    def send_notifications
      @project.all_involved_users(except_user: current_user, include_commenters: true).each do |user|
        Notifications::NewComment.create!(user_related: current_user, user_target: user,
                                          project: @project, comment: @comment)
      end
    end

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
