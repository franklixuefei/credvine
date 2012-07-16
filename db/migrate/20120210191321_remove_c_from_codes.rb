class RemoveCFromCodes < ActiveRecord::Migration
  def up
    remove_column :codes, :cust_success_code
    remove_column :codes, :cust_success_status
  end

  def down
    add_column :codes, :cust_success_status, :string
    add_column :codes, :cust_success_code, :string
  end
end
