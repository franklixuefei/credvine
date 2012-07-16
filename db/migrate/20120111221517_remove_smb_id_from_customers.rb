class RemoveSmbIdFromCustomers < ActiveRecord::Migration
  def up
    remove_column :customers, :smb_id
  end

  def down
    add_column :customers, :smb_id, :integer
  end
end
