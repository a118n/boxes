class Device < ApplicationRecord
  has_many :device_supplies
  has_many :supplies, through: :device_supplies
  belongs_to :site

  validates :name, presence: true, uniqueness: { scope: :site,
                                                 case_sensitive: false }
  validates :devtype, presence: true
  validates :state, presence: true
  validate :check_associations

  before_save :remove_location_if_inactive, if: :state_changed?, on: :update

  scope :in_repair, -> { where(state: "In Repair").order("name") }

  searchkick word_middle: [:name, :model, :location, :sn, :sku], callbacks: :async

  def search_data
    {
      name: name,
      model: model,
      location: location,
      sn: sn,
      sku: sku
    }
  end

  private

  def check_associations
    if supplies.any? && site_id_changed?
      errors.add(:site_id, "cannot be changed. Remove assigned supplies first.")
    end
  end

  def remove_location_if_inactive
    self.location = "" if self.state == "Inactive"
  end
end