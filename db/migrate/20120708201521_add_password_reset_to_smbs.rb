class AddPasswordResetToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :password_reset_token, :string
    add_column :smbs, :password_reset_sent_at, :datetime
  end
end
