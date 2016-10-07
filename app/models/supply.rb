class Supply < ApplicationRecord
  before_save :add_used_supplies, if: :quantity_changed?, on: :update

  has_many :device_supplies
  has_many :devices, through: :device_supplies
  has_many :versions, dependent: :destroy
  belongs_to :site

  validates :name, presence: true, uniqueness: { scope: :site,
                                                 case_sensitive: false }
  validates :quantity, :threshold, :used, presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than: 2147483648 }

  validate :check_associations

  scope :ending_soon, -> { where("quantity <= threshold AND threshold != 0") }
  scope :most_used, -> { where("used > 0").order("used DESC").limit(10) }

  private

  def check_associations
    if self.devices.any? && site_id_changed?
      errors.add(:site_id, "cannot be changed. Remove assigned devices first.")
    end
  end

  def add_used_supplies
    # Add substracted amount to :used attribute
    if !quantity_was.nil? && quantity < quantity_was
      self.used += quantity_was - quantity
    end
  end
end