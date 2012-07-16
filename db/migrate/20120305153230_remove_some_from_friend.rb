class RemoveSomeFromFriend < ActiveRecord::Migration
  def up
    remove_column :friends, :twitter
    remove_column :friends, :facebook
  end

  def down
    add_column :friends, :facebook, :string
    add_column :friends, :twitter, :string
  end
end
