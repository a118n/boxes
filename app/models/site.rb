class Site < ApplicationRecord
  has_many :devices, dependent: :destroy
  has_many :supplies, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
