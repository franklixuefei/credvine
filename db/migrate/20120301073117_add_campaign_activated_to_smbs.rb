class AddCampaignActivatedToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :campaign_activated, :boolean
  end
end
