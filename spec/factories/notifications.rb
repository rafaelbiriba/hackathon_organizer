FactoryBot.define do
  factory :notification_project, class: Notification do
    association :project
    association :user_related, factory: :user
    association :user_target, factory: :user
  end

  factory :notification_new_comment, class: "Notifications::NewComment", parent: :notification_project  do
    comment { create(:comment, project: project) }
  end

  factory :notification_new_thumbs_up, class: "Notifications::NewThumbsUp", parent: :notification_project

  factory :notification_removed_thumbs_up, class: "Notifications::RemovedThumbsUp", parent: :notification_project

  factory :notification_user_subscribed, class: "Notifications::UserSubscribed", parent: :notification_project

  factory :notification_user_unsubscribed_by_admin, class: "Notifications::UserUnsubscribedByAdmin", parent: :notification_project

  factory :notification_user_unsubscribed, class: "Notifications::UserUnsubscribed", parent: :notification_project
end
