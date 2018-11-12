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
  class NewComment < Notification
    def title
      "New comment"
    end

    def text
      "New comment from <b>#{user_related.name}</b> at the project <b>#{short_project_title}</b>"
    end

    def link
      edition_project_path(project.edition, project, anchor: "comment-#{comment.id}")
    end

    def self.notify_all_involved_users(comment)
      comment.project.all_involved_users(except_user: comment.owner, include_commenters: true).each do |involved_user|
        self.create!(user_related: comment.owner, user_target: involved_user, project: comment.project, comment: comment)
      end
    end
  end
end
