class ChangeDateTypeForCampaignStartDate < ActiveRecord::Migration
  def up
    change_table :campaigns do |t|
      t.change :start_date, :date
      t.change :end_date, :date
      t.change :exp_date, :date
    end
  end

  def down
      t.change :start_date, :datetime
      t.change :end_date, :datetime
      t.change :exp_date, :datetime
  end
end
