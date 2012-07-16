class AddMakeCustIncentiveASurpriseToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :make_cust_incentive_a_surprise, :boolean
  end
end
