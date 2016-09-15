FactoryGirl.define do
  factory :site do
    name { Faker::Space.moon }
    location { Faker::Space.star_cluster }
    description { Faker::Lorem.paragraph }
  end
end