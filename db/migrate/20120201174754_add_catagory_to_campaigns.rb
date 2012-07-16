class AddCatagoryToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :catagory, :string
  end
end
