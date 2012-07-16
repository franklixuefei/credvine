class RemoveCatagoryFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :catagory
  end

  def down
    add_column :smbs, :catagory, :string
  end
end
