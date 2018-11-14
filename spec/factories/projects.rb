FactoryBot.define do
  factory :project do
    title { Faker::Lorem.sentence(15) }
    description { Faker::Lorem.sentence(90) }
    association :owner, factory: :user
    edition { Edition.active_now || association(:edition) }
  end
end
