module Notifications
  class UserUnsubscribed < Notification
    def title
      "User unsubscribed"
    end

    def text
      "The user <b>#{user_related.name}</b> just <b>unsubscribed</b> from the project <b>#{project_title}</b>"
    end

    def link
      project_path(project, anchor: "subscribers-list")
    end
  end
end
