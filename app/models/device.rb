class Device < ApplicationRecord
  resourcify
  has_many :device_supplies
  has_many :supplies, through: :device_supplies
  has_many :repairs
  belongs_to :site

  validates :name, presence: true, uniqueness: { scope: :site,
                                                 case_sensitive: false }
  validates :devtype, presence: true
  validates :status, presence: true

  before_save :remove_location_if_inactive, if: :status_changed?, on: :update

  scope :in_repair, -> { where(status: "In Repair").order("name") }

  searchkick word_middle: [:name], callbacks: :async

  DEVICE_TYPES = ['Printer', 'Scanner', 'Other']
  DEVICE_STATUSES = ['Active', 'Inactive', 'In Repair']

  def search_data
    {
      name: name,
      sn: sn,
      asset_tag: asset_tag
    }
  end

  private

  def remove_location_if_inactive
    self.location = "" if self.status == "Inactive"
  end
end
