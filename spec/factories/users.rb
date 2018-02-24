FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }

    profile_image_url do
      Faker::Avatar.image(Faker::Internet.slug(name), "200x200", "jpg", "set#{Random.rand(1..4)}", "bg#{Random.rand(1..2)}")
    end

    email do
      if Settings.allowed_domain.blank?
        Faker::Internet.email
      else
        "#{Faker::Internet.user_name(6..16)}@#{Settings.allowed_domain}"
      end
    end
  end
end
