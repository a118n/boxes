class Device < ApplicationRecord
  has_many :device_supplies
  has_many :supplies, through: :device_supplies
  belongs_to :site

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :devtype, presence: true
  validates :state, presence: true

  scope :in_repair, -> { where("state = 'In Repair'") }
end
