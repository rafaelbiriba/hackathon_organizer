FactoryBot.define do
  factory :project do
    title { Faker::Lorem.sentence(word_count: 15) }
    description { Faker::Lorem.sentence(word_count: 90) }
    association :owner, factory: :user
  end
end
