class AddFilePathToDataFiles < ActiveRecord::Migration
  def change
    add_column :data_files, :file_path, :string
  end
end
