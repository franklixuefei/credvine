class AddXxxxxxToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :init_thx_greeting, :string

    add_column :campaigns, :final_thx_greeting, :string

    add_column :campaigns, :thx_frien_greeting, :string

    add_column :campaigns, :frien_welc_header_greeting, :string

  end
end
