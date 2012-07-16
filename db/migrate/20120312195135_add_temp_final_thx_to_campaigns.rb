class AddTempFinalThxToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :temp_final_thx, :text

  end
end
