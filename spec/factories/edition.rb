FactoryBot.define do
  factory :edition do
    title { "Edition #{Time.now.to_s}" }
    starts_at { Time.now }
    finishes_at { starts_at + 2.days }
  end
end
