class AddCampaignLaunchedToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :campaign_launched, :boolean

  end
end
