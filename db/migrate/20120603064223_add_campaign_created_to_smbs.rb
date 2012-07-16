class AddCampaignCreatedToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :campaign_created, :boolean
  end
end
