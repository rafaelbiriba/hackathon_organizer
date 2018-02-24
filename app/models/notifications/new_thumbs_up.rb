module Notifications
  class NewThumbsUp < Notification
    def title
      "New thumbs up"
    end

    def text
      "The user <b>#{user_related.name}</b> just <b>thumbs up</b> the project <b>#{project_title}</b>"
    end

    def link
      project_path(project)
    end
  end
end
