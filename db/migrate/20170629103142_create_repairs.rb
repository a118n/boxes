class CreateRepairs < ActiveRecord::Migration[5.1]
  def change
    create_table :repairs do |t|
      t.string :ticket_id
      t.text :description
      t.integer :status, default: 2
      t.references :device

      t.timestamps
    end
  end
end
