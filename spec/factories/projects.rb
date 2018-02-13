FactoryBot.define do
  factory :project do
    title "Title"
    description "Description"
    association :owner, factory: :user
  end
end
