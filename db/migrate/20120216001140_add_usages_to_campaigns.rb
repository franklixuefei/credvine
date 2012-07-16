class AddUsagesToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :term_of_use, :text
    add_column :campaigns, :term_of_use_csi, :text
  end
end
