FactoryBot.define do
  factory :comment do
    body "Comment!"
    association :owner, factory: :user
  end
end
