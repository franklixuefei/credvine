class AddIncentiveValsToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :incentive_val, :decimal
    add_column :incentives, :incentive_val_csi, :decimal
    add_column :incentives, :incentive_val_fi, :decimal
  end
end
