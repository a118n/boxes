class AddVendorToSupplies < ActiveRecord::Migration[5.0]
  def change
    add_column :supplies, :vendor, :string
  end
end
