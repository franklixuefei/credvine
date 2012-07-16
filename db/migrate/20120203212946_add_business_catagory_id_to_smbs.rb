class AddBusinessCatagoryIdToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :business_catagory_id, :integer
  end
end
