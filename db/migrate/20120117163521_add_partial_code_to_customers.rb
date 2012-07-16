class AddPartialCodeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :partial_code, :string
  end
end
