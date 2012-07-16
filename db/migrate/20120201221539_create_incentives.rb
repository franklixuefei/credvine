class CreateIncentives < ActiveRecord::Migration
  def change
    create_table :incentives do |t|
      t.string :cust_sent_incentive
      t.string :cust_successful_incentive
      t.string :frien_incentive

      t.timestamps
    end
  end
end
