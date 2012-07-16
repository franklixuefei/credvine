class AddNofityMePerSuccRefToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :notify_me_per_succ_ref, :boolean

  end
end
