class AddProfileCompletedToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :profile_completed, :boolean

  end
end
