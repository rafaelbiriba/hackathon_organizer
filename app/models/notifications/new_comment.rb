module Notifications
  class NewComment < Notification
    def title
      "New comment"
    end

    def text
      "New comment from <b>#{user_related.name}</b> at the project <b>#{project_title}</b>"
    end

    def link
      project_path(project, anchor: "comment-#{comment.id}")
    end
  end
end
