FactoryGirl.define do
  factory :device do
    name { ["PCOL", "PBLK"].sample + "00" + Faker::Number.number(2) + ["A3", "A4"].sample }
    devtype "Printer"
    model { ["HP Color LaserJet 5550", "HP Color LaserJet CM6030 MFP", "HP Color LaserJet CP3505", "HP Laserjet 600 M601", "HP LaserJet Pro MFP M521dn", "HP Officejet Pro X576dw MFP"].sample }
    state { ["Active", "Inactive", "In Repair"].sample }
    ip { Faker::Internet.ip_v4_address }
    location { Faker::Space.agency }
    sn { Faker::Code.asin }
    site_id 1
  end
end
