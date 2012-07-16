class AddPasswordHashToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :password_hash, :string
  end
end
