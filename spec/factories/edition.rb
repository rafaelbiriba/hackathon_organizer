FactoryBot.define do
  factory :edition do
    transient do
      base_date { Time.now }
    end

    title { "Edition #{base_date.to_s}" }
    registration_start_date { base_date - 2.days }
    start_date { base_date }
    end_date { start_date + 2.days }
  end
end
