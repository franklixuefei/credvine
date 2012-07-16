class AddSmbItToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :smb_id, :integer

  end
end
