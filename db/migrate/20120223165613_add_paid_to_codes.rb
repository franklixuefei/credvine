class AddPaidToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :paid, :boolean
  end
end
