class RemoveAmountToPayFromSmbs < ActiveRecord::Migration
  def up
    remove_column :smbs, :amount_to_pay
  end

  def down
    add_column :smbs, :amount_to_pay, :decimal
  end
end
