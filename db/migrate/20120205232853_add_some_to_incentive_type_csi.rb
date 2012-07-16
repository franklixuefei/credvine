class AddSomeToIncentiveTypeCsi < ActiveRecord::Migration
  def change
    add_column :incentive_type_csis, :type_of_incentive_exp, :string
  end
end
