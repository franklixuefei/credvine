class RemoveLogoNameFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :logo_name
  end

  def down
    add_column :smbs, :logo_name, :string
  end
end
