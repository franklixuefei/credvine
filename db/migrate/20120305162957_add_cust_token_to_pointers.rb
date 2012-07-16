class AddCustTokenToPointers < ActiveRecord::Migration
  def change
    add_column :pointers, :cust_token, :string
  end
end
