class AddFirstTimeToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :first_time, :boolean, :default => true

  end
end
