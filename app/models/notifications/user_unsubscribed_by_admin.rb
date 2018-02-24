module Notifications
  class UserUnsubscribedByAdmin < Notification
    def title
      "User unsubscribed by admin"
    end

    def text
      "The <b>ADMIN user</b> just <b>unsubscribed</b> <b>#{user_related.name}</b> from the project <b>#{project_title}</b>"
    end

    def link
      project_path(project, anchor: "subscribers-list")
    end
  end
end
