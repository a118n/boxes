FactoryGirl.define do
  factory :site do
    name { Faker::Space.moon }
    location { Faker::Space.galaxy }
    description { Faker::Lorem.paragraph }
  end
end