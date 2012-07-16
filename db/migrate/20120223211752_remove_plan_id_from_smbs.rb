class RemovePlanIdFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :plan_id
  end

  def down
    add_column :smbs, :plan_id, :integer
  end
end
