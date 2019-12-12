FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }

    profile_image_url do
      Faker::Avatar.image(slug: Faker::Internet.slug(words: name), size: "200x200", format: "jpg", set: "set#{Random.rand(1..4)}", bgset: "bg#{Random.rand(1..2)}")
    end

    email do
      username = name.parameterize
      if Settings.allowed_domain.blank?
        Faker::Internet.email(name: username)
      else
        "#{username}@#{Settings.allowed_domain}"
      end
    end
  end
end
