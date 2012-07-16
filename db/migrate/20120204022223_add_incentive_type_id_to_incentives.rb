class AddIncentiveTypeIdToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :incentive_type_id, :integer
  end
end
