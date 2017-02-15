class SupplyWorker
  include Sidekiq::Worker

  def perform
    @month = Time.zone.now.ago(1.month).end_of_month.strftime("%B")
    @year = Time.zone.now.ago(1.month).end_of_month.strftime("%Y")

    Site.all.each do |s|
      @site = s
      # Send monthly usage report prior to resetting :used attribute
      SupplyMailer.monthly_usage(@month, @year, @site).deliver_now
    end

    Supply.all_used.each do |s|
      # Create version before resetting the counter and make sure date of the version is the end of previous month
      s.versions.create(used: s.used, site_id: s.site_id,
                        created_at: Time.zone.now.ago(1.month).end_of_month)
      s.update_attribute(:used, 0)
    end
  end
end