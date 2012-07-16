class AddSmbIdToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :smb_id, :integer
  end
end
