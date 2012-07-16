class AddTempToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :temp, :boolean, :default => true

  end
end
