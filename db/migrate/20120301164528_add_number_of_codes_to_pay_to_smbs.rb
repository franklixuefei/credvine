class AddNumberOfCodesToPayToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :num_of_codes_to_pay, :integer, :default => 0
  end
end
