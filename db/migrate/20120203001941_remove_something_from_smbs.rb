class RemoveSomethingFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :state_prov
    remove_column :smbs, :country
    remove_column :smbs, :photo_name
  end

  def down
    add_column :smbs, :photo_name, :string
    add_column :smbs, :country, :string
    add_column :smbs, :state_prov, :string
  end
end
