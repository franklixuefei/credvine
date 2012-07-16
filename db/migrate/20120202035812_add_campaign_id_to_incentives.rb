class AddCampaignIdToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :campaign_id, :integer
  end
end
