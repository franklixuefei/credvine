class AddSomethingToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :give_cust_ref_sent, :boolean
    add_column :campaigns, :give_cust_success, :boolean
    add_column :campaigns, :give_frien, :boolean
  end
end
