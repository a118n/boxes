class SupplyWorker
  include Sidekiq::Worker

  def perform
    @month = Time.zone.now.ago(1.month).end_of_month.strftime("%B")
    @year = Time.zone.now.ago(1.month).end_of_month.strftime("%Y")

    Site.all.each do |s|
      @site = s
      SupplyMailer.monthly_usage(@month, @year, @site).deliver_now
    end

    Supply.all_used.each { |s| s.update_attribute(:used, 0) }
    DeviceSupply.all_used.each { |s| s.update_attribute(:used, 0) }
  end
end
