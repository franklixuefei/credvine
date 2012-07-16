class DropPointers < ActiveRecord::Migration
  def up
    drop_table :pointers
  end

  def down
  end
end
