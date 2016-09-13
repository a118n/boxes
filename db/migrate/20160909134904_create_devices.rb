class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :devtype
      t.string :model
      t.string :state, default: "Active"
      t.string :ip
      t.string :location
      t.string :sn
      t.belongs_to :site, index: true, unique: true, foreign_key: true
      t.timestamps
    end
  end
end
