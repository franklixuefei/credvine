class AddSomeFieldToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :business_description, :string

  end
end
