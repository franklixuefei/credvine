class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :username
      t.string :password
      t.string :fullname
      t.string :phone
      t.string :email
      t.string :photo
      #t.integer :smb_id

      t.timestamps
    end
    #add_index :customers, :smb_id
  end
end
