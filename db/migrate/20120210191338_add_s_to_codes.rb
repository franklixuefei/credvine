class AddSToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :cust_success_code, :string
    add_column :codes, :cust_success_status, :string, :default => "NOT_SENT"
  end
end
