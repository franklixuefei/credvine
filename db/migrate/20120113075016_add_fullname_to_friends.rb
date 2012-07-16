class AddFullnameToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :fullname, :string
  end
end
