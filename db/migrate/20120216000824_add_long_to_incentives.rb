class AddLongToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :frien_incentive_long, :text
  end
end
