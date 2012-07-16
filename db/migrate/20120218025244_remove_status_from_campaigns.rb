class RemoveStatusFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :status
  end

  def down
    add_column :campaigns, :status, :boolean
  end
end
