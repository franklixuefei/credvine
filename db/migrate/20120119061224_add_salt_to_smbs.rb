class AddSaltToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :password_salt, :string
  end
end
