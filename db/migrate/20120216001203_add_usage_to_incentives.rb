class AddUsageToIncentives < ActiveRecord::Migration
  def change
    add_column :incentives, :term_of_use_fi, :text
  end
end
