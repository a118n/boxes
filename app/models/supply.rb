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

  searchkick word_middle: [:name], callbacks: :async

  def search_data
    {
      name: name
    }
  end

  def get_yearly_usage_data(year)
    @supply = self
    @year = year
    @results = {}
    (1..12).each do |month|
      @date = Date.new(@year, month, 1)
      @version = @supply.versions.where(created_at: @date.beginning_of_day .. @date.end_of_day).first
      @results.store(@date.prev_month.strftime("%B"), @version.reify.used) unless @version.nil?
    end
    return @results
  end

  def get_monthly_usage_data(year, month)
    @supply = self
    # Result for the month we pass are in fact available on the next month, i.e. July's results are available in August, because we reset counters on the first day of each month, thus .next_month in date
    @date = Date.new(year, month, 1).next_month
    @results = {}
    @supply_version = @supply.versions.where(created_at: @date.beginning_of_day .. @date.end_of_day).first
    unless @supply_version.nil?
      @unaccounted = @supply_version.reify.used
      @supply.devices.each do |device|
        name = device.name
        device_supply_version = device.device_supplies.where(supply_id: @supply.id).first.versions.where(created_at: @date.beginning_of_day .. @date.end_of_day).first
        unless device_supply_version.nil?
          used = device_supply_version.reify.used
          @results.store(name, used)
          @unaccounted -= used
        end
      end
      @results.store("Unaccounted", @unaccounted) unless @unaccounted == 0
    end
    @results = @results.sort_by { |key, value| value }.reverse.to_h
    return @results
  end

  private

  def add_used_supplies
    # Add substracted amount to :used attribute
    self.used += quantity_was - quantity if !quantity_was.nil? && quantity < quantity_was
  end

end
