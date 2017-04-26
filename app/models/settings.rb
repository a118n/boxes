class Settings < ApplicationRecord
  belongs_to :user

  validates :overview_limit, numericality:
  { greater_than_or_equal_to: 0, less_than: 2147483648, allow_nil: true }

end