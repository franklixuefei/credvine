class AddSubjectsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :init_thx_subject, :string

    add_column :campaigns, :final_thx_subject, :string

    add_column :campaigns, :friend_welc_header_subject, :string

    add_column :campaigns, :thx_frien_subject, :string

  end
end
