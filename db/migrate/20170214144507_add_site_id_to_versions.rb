class AddSiteIdToVersions < ActiveRecord::Migration[5.0]
  def change
    add_column :versions, :site_id, :integer
  end
end
