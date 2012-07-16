class AddCampaignIdToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :campaign_id, :integer
  end
end
