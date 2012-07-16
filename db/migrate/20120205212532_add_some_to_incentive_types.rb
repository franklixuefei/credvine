class AddSomeToIncentiveTypes < ActiveRecord::Migration
  def change
    add_column :incentive_types, :type_of_incentive_exp, :string
  end
end
