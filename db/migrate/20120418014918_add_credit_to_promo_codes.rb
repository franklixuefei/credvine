class AddCreditToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :credit, :string

  end
end
