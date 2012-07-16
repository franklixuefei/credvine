class AddPartialCodeToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :partial_code, :string
  end
end
