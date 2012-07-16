class RemoveTypeFromIncentiveTypes < ActiveRecord::Migration
  def up
    remove_column :incentive_types, :type
  end

  def down
    add_column :incentive_types, :type, :string
  end
end
