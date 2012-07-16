class AddExpDateToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :exp_date, :datetime
  end
end
