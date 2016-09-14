class Supply < ApplicationRecord
  has_many :device_supplies
  has_many :devices, through: :device_supplies
  belongs_to :site

  validates :name, presence: true
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 0 }
  validates :threshold, presence: true,
                        numericality: { greater_than_or_equal_to: 0 }

  scope :ending_soon, -> { where("quantity <= threshold AND threshold != 0") }
end
