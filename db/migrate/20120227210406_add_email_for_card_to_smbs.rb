class AddEmailForCardToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :email_for_card, :string
  end
end
