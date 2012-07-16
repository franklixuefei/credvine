class AddCampaignConfirmedToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :campaign_confirmed, :boolean

  end
end
