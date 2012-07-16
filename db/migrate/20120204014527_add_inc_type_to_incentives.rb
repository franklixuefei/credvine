class AddIncTypeToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :inc_type, :string
  end
end
