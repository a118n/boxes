class CreateDeviceSupplies < ActiveRecord::Migration[5.0]
  def change
    create_table :device_supplies do |t|
      t.belongs_to :device, index: true
      t.belongs_to :supply, index: true
      t.timestamps
    end
  end
end
