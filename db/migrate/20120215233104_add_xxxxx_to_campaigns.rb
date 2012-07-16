class AddXxxxxToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :incentive_type_csi_id, :integer
    add_column :campaigns, :incentive_type_id, :integer
    add_column :campaigns, :cust_sent_incentive, :text
    add_column :campaigns, :cust_successful_incentive, :text
    add_column :campaigns, :incentive_val, :decimal
    add_column :campaigns, :incentive_val_csi, :decimal
  end
end
