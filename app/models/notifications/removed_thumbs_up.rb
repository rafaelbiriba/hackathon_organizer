module Notifications
  class RemovedThumbsUp < Notification
    def title
      "Thumbs up removed"
    end

    def text
      "The user <b>#{user_related.name}</b> just removed the <b>thumbs up</b> from the project <b>#{project_title}</b>"
    end

    def link
      project_path(project)
    end
  end
end
