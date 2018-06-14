# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  project_id :integer          indexed
#  owner_id   :integer          indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: "User"

  validates_presence_of :body

  after_create :send_notifications

  private
  def send_notifications
    Notifications::NewComment.notify_all_involved_users(self)
  end
end
