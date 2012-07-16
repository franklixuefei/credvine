class AddFrienWelcHeaderToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :frien_welc_header, :text

  end
end
