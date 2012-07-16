class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :smb_id
      t.string :email

      t.timestamps
    end
  end
end
