class AddAuthTokenToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :auth_token, :string
  end
end
