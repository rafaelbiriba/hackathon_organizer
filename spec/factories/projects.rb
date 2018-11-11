FactoryBot.define do
  factory :project do
    title { Faker::Lorem.sentence(15) }
    description { Faker::Lorem.sentence(90) }
    association :owner, factory: :user
    association :edition, factory: :edition
  end
end
