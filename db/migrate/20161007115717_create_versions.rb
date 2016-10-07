class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.integer :used, default: 0
      t.belongs_to :supply, index: true

      t.timestamps
    end
  end
end
