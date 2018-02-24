FactoryBot.define do
  factory :thumbs_up do
    association :creator, factory: :user
    association :project
  end
end
