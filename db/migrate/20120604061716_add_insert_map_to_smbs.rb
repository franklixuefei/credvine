class AddInsertMapToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :insert_map, :boolean, :default => true
  end
end
