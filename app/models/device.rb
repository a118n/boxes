class Device < ApplicationRecord
  has_many :device_supplies
  has_many :supplies, through: :device_supplies
  belongs_to :site
end
