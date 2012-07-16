class AddAdminToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :admin, :boolean
  end
end
