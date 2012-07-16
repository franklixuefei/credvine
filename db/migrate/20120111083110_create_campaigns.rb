class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :camp_name
      t.text :cus_inc
      t.text :cus_inc_abbr
      t.text :frien_inc
      t.text :frien_inc_abbr
      t.datetime :start_date
      t.datetime :end_date
      t.text :welc_frien
      t.text :thx_frien
      t.text :init_thx
      t.text :final_thx

      t.timestamps
    end
  end
end
