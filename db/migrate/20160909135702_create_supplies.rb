class CreateSupplies < ActiveRecord::Migration[5.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.integer :used, default: 0
      t.integer :threshold, default: 3
      t.boolean :notified, default: false
      t.belongs_to :site, index: true
      t.timestamps
    end
  end
end
