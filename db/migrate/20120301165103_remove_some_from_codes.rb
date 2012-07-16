class RemoveSomeFromCodes < ActiveRecord::Migration
  def up
    remove_column :codes, :paid_for_ref_sent
  end

  def down
    add_column :codes, :paid_for_ref_sent, :boolean
  end
end
