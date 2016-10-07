class SupplyWorker
  include Sidekiq::Worker

  def perform

    Supply.all.each do |s|
      # Create versions before resetting the counter and make sure date of the version is previous month's end
      s.versions.create(used: s.used, created_at: Date.current
                                                      .ago(1.month)
                                                      .end_of_month)
    end
    
    Supply.all.each { |s| s.update_attribute(:used, 0) }
  end
end