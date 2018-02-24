FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name "Mr. Awesome Bot"
    email
  end
end
