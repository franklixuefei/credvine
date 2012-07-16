class AddSomeToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :incentive_type_csi_id, :integer
    add_column :incentives, :incentive_type_fi_id, :integer
  end
end
