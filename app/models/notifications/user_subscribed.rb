# == Schema Information
#
# Table name: notifications
#
#  id              :bigint(8)        not null, primary key
#  project_id      :integer          indexed
#  comment_id      :integer          indexed
#  user_related_id :integer          indexed
#  user_target_id  :integer          indexed, indexed => [visualized]
#  visualized      :boolean          default(FALSE), indexed => [user_target_id]
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  extras          :text
#  type            :string           indexed
#

module Notifications
  class UserSubscribed < Notification
    def title
      "User subscribed"
    end

    def text
      "The user <b>#{user_related.name}</b> just <b>subscribed</b> to the project <b>#{short_project_title}</b>"
    end

    def link
      edition_project_path(project, anchor: "subscribers-list")
    end
  end
end
