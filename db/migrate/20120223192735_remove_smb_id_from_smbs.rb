class RemoveSmbIdFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :smb_id
  end

  def down
    add_column :smbs, :smb_id, :integer
  end
end
