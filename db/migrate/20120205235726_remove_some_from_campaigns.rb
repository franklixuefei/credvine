class RemoveSomeFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :incentive_type_id
    remove_column :campaigns, :incentive_type_csi_id
    remove_column :campaigns, :incentive_type_fi_id
  end

  def down
    add_column :campaigns, :incentive_type_fi_id, :integer
    add_column :campaigns, :incentive_type_csi_id, :integer
    add_column :campaigns, :incentive_type_id, :string
  end
end
