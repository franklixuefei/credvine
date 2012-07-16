class AddFrienWelcToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :frien_welc, :text
  end
end
