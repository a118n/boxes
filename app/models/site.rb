class Site < ApplicationRecord
  has_many :devices, dependent: :destroy
  has_many :supplies, dependent: :destroy
end
