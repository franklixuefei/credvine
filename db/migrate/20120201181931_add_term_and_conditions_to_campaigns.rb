class AddTermAndConditionsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :term_and_conditions, :text
  end
end
