class ResetUsedSuppliesJob < ApplicationJob
  queue_as :default

  def perform
    Supply.all.each { |s| s.update_attribute(:used, 0) }
  end
end
