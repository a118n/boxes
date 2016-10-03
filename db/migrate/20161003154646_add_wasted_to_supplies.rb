class AddWastedToSupplies < ActiveRecord::Migration[5.0]
  def change
    add_column :supplies, :wasted, :integer, default: 0
  end
end
