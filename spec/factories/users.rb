FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
  end
end
