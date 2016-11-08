class Version < ApplicationRecord
  belongs_to :supply

  validates :used, presence: true, numericality: { greater_than_or_equal_to: 0,
                                                   less_than: 2147483648 }

  scope :by_year, lambda { |year| where('extract(year from created_at) = ?', year) }
  scope :by_month, lambda { |month| where('extract(month from created_at) = ?', month) }

end
