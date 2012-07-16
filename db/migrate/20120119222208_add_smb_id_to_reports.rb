class AddSmbIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :smb_id, :integer
  end
end
