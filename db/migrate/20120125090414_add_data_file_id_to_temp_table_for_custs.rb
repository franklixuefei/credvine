class AddDataFileIdToTempTableForCusts < ActiveRecord::Migration
  def change
    add_column :temp_table_for_custs, :data_file_id, :integer
  end
end
