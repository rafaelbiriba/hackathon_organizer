class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper

  belongs_to :user_related, class_name: "User", optional: true
  belongs_to :user_target, class_name: "User"
  belongs_to :project, optional: true
  belongs_to :comment, optional: true

  store :extras

  scope :not_visualized, -> { where(visualized: false) }

  private

  def project_title
    truncate(project.title, length: 70)
  end
end
