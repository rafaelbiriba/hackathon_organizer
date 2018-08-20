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
  class FreeText < Notification
    def title
      extras["title"]
    end

    def text
      extras["text"]
    end

    def link
      extras["link"]
    end
  end
end
