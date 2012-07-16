class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.string :promo_code
      t.integer :promo_credit

      t.timestamps
    end
  end
end
