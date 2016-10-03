FactoryGirl.define do
  factory :supply do
    name { ["CA", "CB", "CC", "CE", "CF"].sample + Faker::Number.number(3) + "A" }
    description { ["Black", "Cyan", "Magenta", "Yellow"].sample + " Cartridge" }
    quantity { Faker::Number.number(2) }
    site # Associated to :site
  end
end
