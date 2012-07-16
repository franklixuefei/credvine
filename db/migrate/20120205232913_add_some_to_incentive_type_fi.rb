class AddSomeToIncentiveTypeFi < ActiveRecord::Migration
  def change
    add_column :incentive_type_fis, :type_of_incentive_exp, :string
  end
end
