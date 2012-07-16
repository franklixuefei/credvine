class AddSmbIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :smb_id, :integer
  end
end
