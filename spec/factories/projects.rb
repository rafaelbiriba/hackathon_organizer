FactoryBot.define do
  factory :project do
    title { Faker::Lorem.sentence(15) }
    description { Faker::Lorem.sentence(30) }
    association :owner, factory: :user
  end
end
