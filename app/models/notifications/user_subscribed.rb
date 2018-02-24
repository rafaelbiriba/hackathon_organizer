module Notifications
  class UserSubscribed < Notification
    def title
      "User subscribed"
    end

    def text
      "The user <b>#{user_related.name}</b> just <b>subscribed</b> to the project <b>#{project_title}</b>"
    end

    def link
      project_path(project, anchor: "subscribers-list")
    end
  end
end
