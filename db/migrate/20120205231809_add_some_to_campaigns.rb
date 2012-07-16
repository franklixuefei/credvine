class AddSomeToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :incentive_type_csi_id, :integer
    add_column :campaigns, :incentive_type_fi_id, :integer
  end
end
