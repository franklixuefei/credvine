class RemoveXxxxxFromIncentives < ActiveRecord::Migration
  def up
    remove_column :incentives, :incentive_type_csi_id
    remove_column :incentives, :incentive_type_id
    remove_column :incentives, :cust_sent_incentive
    remove_column :incentives, :cust_successful_incentive
    remove_column :incentives, :incentive_val
    remove_column :incentives, :incentive_val_csi
  end

  def down
    add_column :incentives, :incentive_val_csi, :decimal
    add_column :incentives, :incentive_val, :decimal
    add_column :incentives, :cust_successful_incentive, :text
    add_column :incentives, :cust_sent_incentive, :text
    add_column :incentives, :incentive_type_id, :integer
    add_column :incentives, :incentive_type_csi_id, :integer
  end
end
