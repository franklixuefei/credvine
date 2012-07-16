class RemoveIncTypeFromIncentives < ActiveRecord::Migration
  def up
    remove_column :incentives, :inc_type
  end

  def down
    add_column :incentives, :inc_type, :string
  end
end
