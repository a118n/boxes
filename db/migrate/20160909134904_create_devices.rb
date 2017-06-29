class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :devtype
      t.string :model
      t.string :status, default: "Active"
      t.string :ip
      t.string :location
      t.string :sn
      t.string :asset_tag
      t.text   :notes
      t.belongs_to :site, index: true
      t.timestamps
    end
  end
end
