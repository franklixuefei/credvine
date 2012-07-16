class RemoveRedeemedFromFriends < ActiveRecord::Migration
  def up
    remove_column :friends, :redeemed?
  end

  def down
    add_column :friends, :redeemed?, :boolean
  end
end
