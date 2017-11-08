class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper

  self.inheritance_column = :_type_disabled

  belongs_to :user_related, class_name: "User", optional: true
  belongs_to :user_target, class_name: "User"
  belongs_to :project, optional: true
  belongs_to :comment, optional: true

  scope :not_visualized, -> { where(visualized: false) }

  def project_title
    truncate(project.title, length: 70)
  end

  def to_hash
    case notification_type
    when "new_comment"
      {
        visualized: visualized,
        title: "New Comment",
        text: "New comment from <b>#{user_related.name}</b> at the project <b>#{project_title}</b>",
        link: project_path(project, anchor: "comment-#{comment.id}"),
        date: created_at
      }
    when "user_subscribed"
      {
        visualized: visualized,
        title: "User subscribed",
        text: "The user <b>#{user_related.name}</b> just <b>subscribed</b> to the project <b>#{project_title}</b>",
        link: project_path(project, anchor: "subscribers-list"),
        date: created_at
      }
    when "user_unsubscribed"
      {
        visualized: visualized,
        title: "User unsubscribed",
        text: "The user <b>#{user_related.name}</b> just <b>unsubscribed</b> from the project <b>#{project_title}</b>",
        link: project_path(project, anchor: "subscribers-list"),
        date: created_at
      }
    when "user_unsubscribed_by_admin"
      {
        visualized: visualized,
        title: "User unsubscribed by admin",
        text: "The <b>ADMIN user</b> just <b>unsubscribed</b> <b>#{user_related.name}</b> from the project <b>#{project_title}</b>",
        link: project_path(project, anchor: "subscribers-list"),
        date: created_at
      }

    when "new_feature_comments"
      {
        visualized: visualized,
        title: "New features: Notification and Comments",
        text: "Enjoy your new comments section at your project page. It's the perfect opportunity to discuss the details before we start hacking!",
        link: nil,
        date: created_at
      }

    else
      {}
    end
  end
end
