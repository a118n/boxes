class AddUsedToDeviceSupplies < ActiveRecord::Migration[5.1]
  def change
    add_column :device_supplies, :used, :integer, default: 0
  end
end
