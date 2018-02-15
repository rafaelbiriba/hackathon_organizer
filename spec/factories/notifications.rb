FactoryBot.define do
  factory :notification_project, class: Notification do
    association :project, factory: :project
    association :user_related, factory: :user
    association :user_target, factory: :user
  end
end
