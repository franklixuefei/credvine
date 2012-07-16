class AddActivationTokenToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :activation_token, :string

  end
end
