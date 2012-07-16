class AddPromoCreditToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :promo_credit, :string

  end
end
