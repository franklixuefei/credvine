class AddSomeToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :smb_partial, :string
    add_column :codes, :cust_partial, :string
    add_column :codes, :frien_partial, :string
  end
end
