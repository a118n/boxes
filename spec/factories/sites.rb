FactoryGirl.define do
  factory :site do
    name { Faker::Space.moon }
    location { Faker::Space.star_cluster }
    description { Faker::Lorem.paragraph }

    factory :site_with_devices do
      transient do
        devices_count 5
      end

      after(:create) do |site, evaluator|
        create_list(:device, evaluator.devices_count, site: site)
      end
    end # factory :site_with_devices

    factory :site_with_supplies do
      transient do
        supplies_count 5
      end

      after(:create) do |site, evaluator|
        create_list(:device, evaluator.supplies_count, site: site)
      end
    end # factory :site_with_supplies

    factory :site_with_everything do
      transient do
        devices_count 5
        supplies_count 5
      end

      after(:create) do |site, evaluator|
        create_list(:device, evaluator.devices_count, site: site)
        create_list(:supply, evaluator.supplies_count, site: site)
      end
    end # factory :site_with_everything

  end # factory :site
end