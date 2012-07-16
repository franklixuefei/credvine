class RemoveTempFinalThxFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :temp_final_thx
      end

  def down
    add_column :campaigns, :temp_final_thx, :text
  end
end
