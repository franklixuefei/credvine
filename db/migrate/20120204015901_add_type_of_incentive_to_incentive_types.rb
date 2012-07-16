class AddTypeOfIncentiveToIncentiveTypes < ActiveRecord::Migration
  def change
    add_column :incentive_types, :type_of_incentive, :string
  end
end
