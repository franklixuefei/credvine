class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :cust_init_code
      t.string :cust_success_code
      t.string :frien_code
      t.string :cust_init_status, :default => 'SENT' 
      t.string :cust_success_status, :default => 'SENT' 
      t.string :frien_status, :default => 'SENT' 

      t.timestamps
    end
  end
end
