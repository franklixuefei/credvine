class AddPlanIdToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :plan_id, :integer
  end
end
