class RemovePaypalToSubscriptionsFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :PaypalToSubscriptions
  end

  def down
    add_column :subscriptions, :PaypalToSubscriptions, :string
  end
end
