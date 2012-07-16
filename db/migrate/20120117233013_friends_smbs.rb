class FriendsSmbs < ActiveRecord::Migration
  def up
    create_table :friends_smbs, :id => false do |t|
      t.references :friend
      t.references :smb
      t.timestamps
    end
  end

  def down
    drop_table :friends_smbs
  end
end