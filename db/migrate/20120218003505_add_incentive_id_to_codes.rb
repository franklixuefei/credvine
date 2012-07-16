class AddIncentiveIdToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :incentive_id, :integer
  end
end
