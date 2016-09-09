class CreateSupplies < ActiveRecord::Migration[5.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.integer :threshold, default: 3
      t.boolean :notified, default: false

      t.timestamps
    end
  end
end
