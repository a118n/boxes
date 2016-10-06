class SupplyWorker
  include Sidekiq::Worker

  def perform
    # Create versions before resetting the counter
    Supply.all.each { |s| s.paper_trail.touch_with_version }

    Supply.all.each { |s| s.update_attribute(:used, 0) }
  end
end