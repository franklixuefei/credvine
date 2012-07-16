class ChangeDataTypeForIncentiveCustSentIncentive < ActiveRecord::Migration
  def up
     change_table :incentives do |t|
      t.change :cust_sent_incentive, :text
      t.change :cust_successful_incentive, :text
      t.change :frien_incentive, :text
     end
  end

  def down
     change_table :incentives do |t|
      t.change :cust_sent_incentive, :string
      t.change :cust_successful_incentive, :string
      t.change :frien_incentive, :string
     end
  end
end
