class AddLongToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :cust_sent_incentive_long, :text
    add_column :campaigns, :cust_successful_incentive_long, :text
  end
end
