FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(Random.rand(5..20)) }
    association :owner, factory: :user
    association :project
  end
end
