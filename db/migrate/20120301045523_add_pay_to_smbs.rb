class AddPayToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :date_of_payment_for_ref, :date
  end
end
