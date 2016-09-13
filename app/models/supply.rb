class Supply < ApplicationRecord
  has_many :device_supplies
  has_many :devices, through: :device_supplies
  belongs_to :site
end
