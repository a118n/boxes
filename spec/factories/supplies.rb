FactoryGirl.define do
  factory :supply do
    name { ["CB381A", "CC364A", "CE250A", "CE390A", "CF300A"].sample }
    description { Faker::Color.color_name.capitalize + " Cartridge" }
    quantity { Faker::Number.number(2) }
    site_id 1
  end
end
