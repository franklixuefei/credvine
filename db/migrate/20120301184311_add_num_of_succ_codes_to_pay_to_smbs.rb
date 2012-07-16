class AddNumOfSuccCodesToPayToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :num_of_succ_codes_to_pay, :integer
  end
end
