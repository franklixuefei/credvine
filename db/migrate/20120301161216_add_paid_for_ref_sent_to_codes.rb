class AddPaidForRefSentToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :paid_for_ref_sent, :boolean
  end
end
