class Supply < ApplicationRecord
  resourcify
  has_paper_trail

  has_many :device_supplies
  has_many :devices, through: :device_supplies

  belongs_to :site

  validates :name, presence: true
  validates :vendor, presence: true
  validates :quantity, :threshold, :used, presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than: 2147483648 }

  before_save :add_used_supplies, if: :quantity_changed?, on: :update

  scope :ending_soon, -> { where("quantity <= threshold AND threshold != 0")
                           .order("quantity") }
  scope :all_used, -> { where("used > 0").order("used DESC") }
  scope :most_used, -> { all_used.limit(30) }

  searchkick word_middle: [:name, :description], callbacks: :async

  def search_data
    {
      name: name,
      description: description
    }
  end

  private

  def add_used_supplies
    # Add substracted amount to :used attribute
    self.used += quantity_was - quantity if !quantity_was.nil? && quantity < quantity_was
  end

end
