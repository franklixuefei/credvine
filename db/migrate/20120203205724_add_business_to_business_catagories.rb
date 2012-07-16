class AddBusinessToBusinessCatagories < ActiveRecord::Migration
  def change
    add_column :business_catagories, :business, :string
  end
end
