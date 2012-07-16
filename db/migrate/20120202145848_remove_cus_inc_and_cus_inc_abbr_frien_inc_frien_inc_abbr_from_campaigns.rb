class RemoveCusIncAndCusIncAbbrFrienIncFrienIncAbbrFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :cus_inc
    remove_column :campaigns, :cus_inc_abbr
    remove_column :campaigns, :frien_inc
    remove_column :campaigns, :frien_inc_abbr
  end

  def down
    add_column :campaigns, :frien_inc_abbr, :text
    add_column :campaigns, :frien_inc, :text
    add_column :campaigns, :cus_inc_abbr, :text
    add_column :campaigns, :cus_inc, :text
  end
end
