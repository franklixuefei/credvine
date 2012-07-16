class AddPeriodToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :period, :string
  end
end
