class DeviceSupply < ApplicationRecord
  belongs_to :device
  belongs_to :supply
end
