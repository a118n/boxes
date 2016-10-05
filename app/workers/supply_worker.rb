class SupplyWorker
  include Sidekiq::Worker

  def perform
    Supply.all.each { |s| s.update_attribute(:used, 0) }
  end
end