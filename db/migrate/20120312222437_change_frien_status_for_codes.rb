class ChangeFrienStatusForCodes < ActiveRecord::Migration
  def up
    change_table :codes do |t|
      t.change :frien_status, :string, :default => "NOT_SENT"
    end
  end

  def down
    change_table :codes do |t|
      t.change :frien_status, :string, :default => "NOT SENT"
    end
  end
end
