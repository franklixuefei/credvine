class AddSmbIdToDataFiles < ActiveRecord::Migration
  def change
    add_column :data_files, :smb_id, :integer
  end
end
