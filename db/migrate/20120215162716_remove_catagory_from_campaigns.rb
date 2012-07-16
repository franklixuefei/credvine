class RemoveCatagoryFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :catagory
  end

  def down
    add_column :campaigns, :catagory, :string
  end
end
