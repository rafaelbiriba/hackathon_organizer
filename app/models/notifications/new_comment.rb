# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
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
  class NewComment < Notification
    def title
      "New comment"
    end

    def text
      "New comment from <b>#{user_related.name}</b> at the project <b>#{short_project_title}</b>"
    end

    def link
      project_path(project, anchor: "comment-#{comment.id}")
    end
  end
end
