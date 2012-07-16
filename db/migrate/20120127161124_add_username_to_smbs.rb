class AddUsernameToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :username, :string
  end
end
