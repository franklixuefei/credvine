class AddIdsToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :smb_id, :integer
    add_column :codes, :customer_id, :integer
    add_column :codes, :friend_id, :integer
  end
end
