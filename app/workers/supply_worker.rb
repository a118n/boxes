class SupplyWorker
  include Sidekiq::Worker

  def perform
    @month = Time.zone.now.ago(1.month).end_of_month.strftime("%B")
    @year = Time.zone.now.ago(1.month).end_of_month.strftime("%Y")

    # Send monthly usage report prior to resetting :used attribute
    SupplyMailer.monthly_usage(@month, @year).deliver_now

    Supply.all.each do |s|
      # Create version before resetting the counter and make sure date of the version is the end of previous month
      s.versions.create(used: s.used, created_at: Time.zone.now.ago(1.month).end_of_month)
      s.update_attribute(:used, 0)
    end
  end
end