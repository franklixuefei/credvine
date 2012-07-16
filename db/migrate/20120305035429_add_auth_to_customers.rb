class AddAuthToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :auth_token, :string
  end
end
