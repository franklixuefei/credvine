class RemoveWelcFrienAndThxFrienAndInitThxAndFinalThxFromCampaigns < ActiveRecord::Migration
  def up
    remove_column :campaigns, :welc_frien

  end

  def down

    add_column :campaigns, :welc_frien, :text
  end
end
