class AddPinToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :PIN, :string
  end
end
