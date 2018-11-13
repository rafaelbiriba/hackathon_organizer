FactoryBot.define do
  factory :edition do
    title { "Edition #{Time.now.to_s}" }
    registration_starts_at { Time.now  - 2.days }
    event_starts_at { Time.now }
    finishes_at { registration_starts_at + 2.days }
  end
end
