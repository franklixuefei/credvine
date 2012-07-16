class AddStripeToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :stripe_customer_token, :string
  end
end
