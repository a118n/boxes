class DeviceSupply < ApplicationRecord
  has_paper_trail

  belongs_to :device
  belongs_to :supply

  scope :all_used, -> { where("used > 0").order("used DESC") }
end
