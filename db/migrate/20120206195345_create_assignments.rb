class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :customer_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
