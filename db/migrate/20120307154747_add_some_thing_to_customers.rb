class AddSomeThingToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :cust_init_coupon_request_times, :integer, :default => 0

    add_column :customers, :cust_init_coupon_redemption_times, :integer, :default => 0

    add_column :customers, :cust_init_sent_at, :datetime, :default => Time.now
  end
end
