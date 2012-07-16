class AddAmountToPayToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :amount_to_pay, :decimal
  end
end
