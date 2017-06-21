class DeviceSupply < ApplicationRecord
  has_paper_trail
  
  belongs_to :device
  belongs_to :supply
end
