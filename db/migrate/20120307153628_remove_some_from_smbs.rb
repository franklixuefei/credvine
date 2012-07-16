class RemoveSomeFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :cust_init_coupon_request_times
        remove_column :smbs, :cust_init_coupon_redemption_times
        remove_column :smbs, :cust_init_sent_at
      end

  def down
    add_column :smbs, :cust_init_sent_at, :datetime
    add_column :smbs, :cust_init_coupon_redemption_times, :integer
    add_column :smbs, :cust_init_coupon_request_times, :integer
  end
end
