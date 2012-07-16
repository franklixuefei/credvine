class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :phone
      t.boolean :redeemed?

      t.timestamps
    end
  end
end
