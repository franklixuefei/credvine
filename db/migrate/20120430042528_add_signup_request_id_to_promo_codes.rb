class AddSignupRequestIdToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :signup_request_id, :integer

  end
end
