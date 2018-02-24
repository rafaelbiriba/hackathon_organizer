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

class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper

  belongs_to :user_related, class_name: "User", optional: true
  belongs_to :user_target, class_name: "User"
  belongs_to :project, optional: true
  belongs_to :comment, optional: true

  store :extras

  scope :not_visualized, -> { where(visualized: false) }
  scope :old_visualized_notifications, -> {
    where("created_at < ? AND visualized = ?", 3.days.ago, true)
  }

  private
  def project_title
    truncate(project.title, length: 70)
  end
end
