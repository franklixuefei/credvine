class RemovePromoCreditFromPromoCodes < ActiveRecord::Migration
  def up
    remove_column :promo_codes, :promo_credit
      end

  def down
    add_column :promo_codes, :promo_credit, :integer
  end
end
