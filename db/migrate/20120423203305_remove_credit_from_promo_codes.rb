class RemoveCreditFromPromoCodes < ActiveRecord::Migration
  def up
    remove_column :promo_codes, :credit
      end

  def down
    add_column :promo_codes, :credit, :string
  end
end
