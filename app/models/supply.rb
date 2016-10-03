class Supply < ApplicationRecord
  before_save :waste, if: :quantity_changed?

  has_many :device_supplies
  has_many :devices, through: :device_supplies
  belongs_to :site

  validates :name, presence: true, uniqueness: { scope: :site,
                                                 case_sensitive: false }
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 0,
                                       less_than: 2147483648 }
  validates :threshold, presence: true,
                        numericality: { greater_than_or_equal_to: 0,
                                        less_than: 2147483648 }
  validate :associations

  scope :ending_soon, -> { where("quantity <= threshold AND threshold != 0") }

  private

  def associations
    if self.devices.any? && site_id_changed?
      errors.add(:site_id, "cannot be changed. Remove assigned devices first.")
    end
  end

  def waste
    self.wasted += quantity_was - quantity if quantity < quantity_was
  end
end
